Return-Path: <SRS0=KsRD=PT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A240C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 20E5B20652
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 11 Jan 2019 17:25:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="SE+ZPRYw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="KRWLRY0F"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 20E5B20652
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lQP2L/1+kCoe61Qh5byihABq+9v/poTXeKGIhe3xed8=; b=SE+ZPRYwqNgYUM
	ftp7qXFUqoySO8FtM5MYeqfhaEYXyKrN4b+lWyGwTgW8lbpqzJ9y23eoXdyVxvqi9oPcWc5yPX7I8
	Htq9IwviOIzyhNl6Ueo7+AidIW7sAZ4OfuiZRTwtafd37ox97MfAGeyyU9IoF3KCNMhMAhkp+0BpG
	HzKefZkiPi0eA3i9MCp6ctTTBfNTp9AZqdA+eeHZCB1KmTyq3Mj8k3033TnZgg36j96K1j+kAUDYT
	Lmxack5lWbBiH8bK3dgKdOssV/PYboBOoJiGCerqLea9M0o4RPCOmI0OLjNsG+dpYObSAehbTFugB
	dDkM7AzleazCrxHDrCKw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gi0YS-00040Q-Ik; Fri, 11 Jan 2019 17:25:12 +0000
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gi0VM-0000NV-C1
 for linux-arm-kernel@lists.infradead.org; Fri, 11 Jan 2019 17:22:05 +0000
Received: by mail-wm1-x343.google.com with SMTP id y8so3097329wmi.4
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 11 Jan 2019 09:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=xBD70HL2qWO03paRwQIDmAlJlPVaPEi3eVQDU8YVxoo=;
 b=KRWLRY0F0rlnDv+yevaEtVPd9HPVrX+LTdoU6A+ijvu7ZMOPU4qM7ax6P/rvDVMsGs
 23AY5Oh/ZZrxMP9xaUabObPNgCxtJlkBfMzFeYZuZGnFmEMgEqd+Ulj3BppJ6QiXl4OH
 kXrRre/lBt9z/FJYMTecJf/o2+VpnV4B1mAkZVnMhKLhVmUClQ70Z5Qw+VlW1lxzZ/yP
 c0LX4YhDgojAKNy8JPPer8EbpOXz3LnrCGJoI9eA5MR6z5uJGzj4UG/8OI1ahP1Wdo38
 Li5O6vdrBaG8A/wPmcqtjscRh/iddp3UxmSfWFMhgIKoLZU3aTrjhs4Es0RMXB38I+4+
 SrFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=xBD70HL2qWO03paRwQIDmAlJlPVaPEi3eVQDU8YVxoo=;
 b=HApadd4Uc3lRicz68rJAFQqrxIW5wDM1uJE9UmutRT1X7NkXoj3z/qu+Wr8VmYVmSu
 lbX3FiFsUDCE7TYlVqT6Vr891yR5JGWBG1cc5NUgPe2kyHcz3eWanHd22nRS6mgboYPk
 mrMzlxk5uQQDrP8zqkqWtwKwvCFErdkzRqfys1/mv+PvHgG60LLECGfSyLz9FDQqxser
 xbFeXj/2dGskiFe1c/ormBDCit/FnifHec/M+kPFsXLCak8fIbUIj6Kckt8ONEeiPtkM
 PhGaS7JI5yjUD8fKbnSZB9ZkY6Y8mDlGsuvV1nojldveEaACBNnVkZzYz0SZY5GVlTcI
 b//g==
X-Gm-Message-State: AJcUukfO1jQSvQPgjEAarzdNKG7fmn9QrkLDGwz0zNAF08z9YACwxdDw
 p9QLvg1ome9JWEfNUuc7FGLJBA==
X-Google-Smtp-Source: ALg8bN45wANz3c7rgmiuLR9X1ICgjFWDGdCeblsSLFC0KdscQ3VOCvOjBhNQluWu800clWt35Ce+DA==
X-Received: by 2002:a1c:7616:: with SMTP id r22mr3084741wmc.35.1547227318742; 
 Fri, 11 Jan 2019 09:21:58 -0800 (PST)
Received: from debian-brgl.home ([2a01:cb1d:af:5b00:6d6c:8493:1ab5:dad7])
 by smtp.gmail.com with ESMTPSA id o16sm78534408wrn.11.2019.01.11.09.21.57
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 11 Jan 2019 09:21:58 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Sekhar Nori <nsekhar@ti.com>, Kevin Hilman <khilman@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>
Subject: [PATCH 07/17] ARM: davinci: dm365: WARN() if clk_get() fails
Date: Fri, 11 Jan 2019 18:21:24 +0100
Message-Id: <20190111172134.30147-8-brgl@bgdev.pl>
X-Mailer: git-send-email 2.19.1
In-Reply-To: <20190111172134.30147-1-brgl@bgdev.pl>
References: <20190111172134.30147-1-brgl@bgdev.pl>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190111_092200_944970_E06A74E9 
X-CRM114-Status: GOOD (  12.76  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org,
 Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Bartosz Golaszewski <bgolaszewski@baylibre.com>

Currently the timer code checks if the clock pointer passed to it is
good (!IS_ERR(clk)). The new clocksource driver expects the clock to
be functional and doesn't perform any checks so emit a warning if
clk_get() fails.

Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
---
 arch/arm/mach-davinci/dm365.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-davinci/dm365.c b/arch/arm/mach-davinci/dm365.c
index 01fb2b0c82de..842b7e706ba1 100644
--- a/arch/arm/mach-davinci/dm365.c
+++ b/arch/arm/mach-davinci/dm365.c
@@ -786,6 +786,7 @@ void __init dm365_init_time(void)
 	dm365_psc_init(NULL, psc);
 
 	clk = clk_get(NULL, "timer0");
+	WARN(IS_ERR(clk), "Unable to get the timer clock\n");
 
 	davinci_timer_init(clk);
 }
-- 
2.19.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
