Return-Path: <SRS0=2lwk=Q5=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43C88C43381
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:37:02 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1092820700
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 22 Feb 2019 19:37:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="pmu/LN3P";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCgQVojB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1092820700
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fH3INno3k6B3tblL10RvAtWiSZWsf6eLy+MSd4MG6SE=; b=pmu/LN3PSwmYGd
	VY8/QXy54FcC5Ijtd+WY37Nf+kphcRq5Lhqgy1zT04iEY6tr4b0UafUBJPjrwrRePwGG15L4E2Maj
	mfP06SKbd90nocEzRmKn3YvV+t+eBBwkL4sPZrwCkhrUo8WDR1ZyGMp8yXF/cudueR5TnNRthl4kt
	88oyDZXrU6g3YQqPkCyc8dIPcki5GKzFInlrJiuhyOWFMnpCkmCUD1AmIlKkVEOTV5DHDkJoF8Wwq
	Ng/luEqByDyFtY69THM0txfv8kD9pArBC9w+Cxo9oAqVzFf1Dbr/yl0U6MrQ+gMxBfV3RgRCrU3pH
	6NJYZjuA8ZkMFlKFRf+Q==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gxGcx-0004uz-65; Fri, 22 Feb 2019 19:36:55 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gxGcC-00046J-DV
 for linux-arm-kernel@lists.infradead.org; Fri, 22 Feb 2019 19:36:17 +0000
Received: by mail-pf1-x441.google.com with SMTP id v21so1529515pfm.12
 for <linux-arm-kernel@lists.infradead.org>;
 Fri, 22 Feb 2019 11:36:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
 b=RCgQVojBuznwodAFTzYzXjJ6qFR8aRc77IK/patxS1lIaPbWbKwujh98X3YuJR6aOW
 oe/wctpSvSvG9rz4/fe0oOUeHIHG5C602p6Bcd7TjxN15wpuBhZv1+7uLdz7Kv/1JNUT
 qxgqEXRyXrq4kd5wha2xQlmApUO1EXcO4/urzgfJDde2ec6ELBKsoyc1HfRIjkiI09x1
 H8rPl2R0oRcHMgunD03StB/fpr4Mdizg/K1y3Iu2iyiFn5LCxS9yIdi4b7DnDM2PNsTd
 GgKVZfaxj6X1mBy1HAldVqwcFlq+6JHE8+suUvg+5nXP6T8NVhAVa7FdY/9IPzi3/ASI
 A3uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=QnRZ3rfzwRbPDDTdc6HzTkn6HQQ4M3T5bbjKD11buGw=;
 b=F/96eCXUv87rgMhz7gbp9RqnX3ixVSd35z/2kqeRS+x1v6ZiPjyhgTuoXkQtlFSwLO
 /uLhm0aiL/5pHiAYv0njMxl2Po+0BRGnz97XL50GmoSZCuoUj9bGeD+htbUP9i0TgViL
 ynVwoSlCjHquQzPyOIflrH+EXeLUw0h7Vt2Kpq+19H5qEVi54y1xJK1ZnyVzHYC8rx0u
 RVne28UvNTprpd1Tw59KbZwBH0gyZUi+AdQFUv+PuDVlWCAmUxzi+EtN9gWT7bXlfNi3
 18AbbKvDm3IQa9G6WoSYje7F/fov32JAg5XYtUD7op3hHMEHHv7ttq+jisn7pt6Hy50a
 xj8Q==
X-Gm-Message-State: AHQUAuYhciABkFYQCmEp2y7CZZld+T9aDH5ruQQYE426gaOFX6X/aDqa
 Ps0lELBqElHcHYX9ohrhIJ4=
X-Google-Smtp-Source: AHgI3IYlzxVgrVdAeFuaC0G+BDObQc44fiSh9qEU91y8vM+CC3ffieRHL/jGFkkByd4Xq4an0AS4sQ==
X-Received: by 2002:a63:61d8:: with SMTP id v207mr5477157pgb.308.1550864168027; 
 Fri, 22 Feb 2019 11:36:08 -0800 (PST)
Received: from localhost.localdomain (ppp91-79-175-49.pppoe.mtu-net.ru.
 [91.79.175.49])
 by smtp.gmail.com with ESMTPSA id e21sm7687190pfh.45.2019.02.22.11.36.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 22 Feb 2019 11:36:07 -0800 (PST)
From: Dmitry Osipenko <digetx@gmail.com>
To: Russell King <linux@armlinux.org.uk>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, Robert Yang <decatf@gmail.com>,
 =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Subject: [PATCH v6 6/7] ARM: tegra: Always boot CPU in ARM-mode
Date: Fri, 22 Feb 2019 22:34:25 +0300
Message-Id: <20190222193426.10747-7-digetx@gmail.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190222193426.10747-1-digetx@gmail.com>
References: <20190222193426.10747-1-digetx@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190222_113608_651585_7F17ABD2 
X-CRM114-Status: GOOD (  12.10  )
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
Cc: linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

CPU always jumps into reset handler in ARM-mode from the Trusted
Foundations firmware, hence let's make CPU to always jump into kernel
in ARM-mode regardless of the firmware presence. This is required to
make Thumb-2 kernel working with the Trusted Foundations firmware on
Tegra30.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/reset-handler.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/mach-tegra/reset-handler.S b/arch/arm/mach-tegra/reset-handler.S
index 6bea95d165fa..3bf202819534 100644
--- a/arch/arm/mach-tegra/reset-handler.S
+++ b/arch/arm/mach-tegra/reset-handler.S
@@ -113,6 +113,7 @@ ENTRY(__tegra_cpu_reset_handler_start)
  *       must be position-independent.
  */
 
+	.arm
 	.align L1_CACHE_SHIFT
 ENTRY(__tegra_cpu_reset_handler)
 
-- 
2.20.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
