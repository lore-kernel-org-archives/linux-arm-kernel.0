Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EB4C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:23 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 972AC20868
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:15:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RO31dDFl";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="e8iQNiQn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 972AC20868
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=no8oLDJWMa/X5cFpTbvKMYs6LXpYSraVpDxyH5i/njs=; b=RO31dDFl8n6CYa1WPbydDc79e1
	ML6Mcuw8KQFsriSOee3BIsRQHZ7PSu80TYL68xzNr9vy1i3y8l+S7yzZUKf5cirWy+4HBPG28OTis
	YHP3v89J4BDNjc5wKbf7sirdA0P/FBHggFVil6PDj3Z0Z7iNtCuYhgYi2p5jdiS0hPBekNg0tCgAq
	VE/yaDAptvFiIvVBcyg1ok2sY3hbT/FM4mCdX3DCMZFcvGhHmVcdaSDgL3jo4LqcOxP1ma3lDOW7C
	q5qN5zOvkmDaQnE3yehazSPgtLvDASbUnnhUElohzAKwbo650Wvp2oPbT7g9x5+1xFXhg8+2YZHF3
	Mpluk/6w==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjrar-0004Ie-TI; Wed, 16 Jan 2019 20:15:21 +0000
Received: from mail-yw1-xc42.google.com ([2607:f8b0:4864:20::c42])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjraT-00031F-0i
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 20:14:58 +0000
Received: by mail-yw1-xc42.google.com with SMTP id i73so2940397ywg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=bPjBy59K4hCzODQ+3TXNaK5jB6A30bX7T9519H++o4I=;
 b=e8iQNiQnREBcjKcRolIBb1fUMq4l8wqAv1dKo5698KeQPOXYop7YrmNS3HZRxIChKm
 3oEdEaKDj6JD4ShxZZZ9t3iqHDd5NOgXyxO5LQL8k0r7SmPPt4qjlEutm9muLJL7Hmyf
 vs3xQXionnuWEnsSYsDfOA2r9u0G+CY1lEfgk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=bPjBy59K4hCzODQ+3TXNaK5jB6A30bX7T9519H++o4I=;
 b=MRU1rbGgWqAr8z3UvKdoIOF+wd4Rl95CxZh1/mgyUgF2t3Bj+DqJCO0h4v6VIZr9lx
 oTHk+K+YJ2gsNsj6SFP4QvuP/Tn6IlF/cEax1mM5ZIKkgH4n4eENNaWBiZ4WF3WsgSt8
 m+RYmvAHDIHLZO9FPe6axUI1obCIkdCidxzrRSvGJU6Gkh2gj+hUWkEn8IN290etAofC
 nAT5awgcDEqNAfIL7SYabsEVVa0nM2TKsyiM/+24Cec4BHJNQ33WC5wGqQItXiZp6Po6
 XJ5xN298bRMcMxWpXMSbkRVGaWzsOb+uCsi58wfWUZAwq8sLQmkSPjtqfTOuC1OmAZ1/
 IrBg==
X-Gm-Message-State: AJcUukdf3nUUt37J39lzvd+T36C3viU2U/Vv0AUimUVbwRRVM7yhPoja
 5SK1hSjVgPw22Mnp6zCU/lRboA==
X-Google-Smtp-Source: ALg8bN6HhgjIeh8OK1IH2cHwkN+oA9mADWA/GUvUoGHhlvEBeA6MXO0aj8+uvt14uejadgxtDsfYEQ==
X-Received: by 2002:a0d:fcc6:: with SMTP id m189mr9667909ywf.71.1547669695705; 
 Wed, 16 Jan 2019 12:14:55 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.14.51
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 12:14:55 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: [PATCH V2 1/4] dt-bindings: pwm: kona: Add new compatible for new
 version pwm-cygnus
Date: Thu, 17 Jan 2019 01:45:13 +0530
Message-Id: <1547669716-20070-2-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_121457_061730_BE3FCA22 
X-CRM114-Status: GOOD (  15.22  )
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
Cc: linux-pwm@vger.kernel.org, Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>,
 Praveen Kumar B <praveen.b@broadcom.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, bcm-kernel-feedback-list@broadcom.com,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

From: Praveen Kumar B <praveen.b@broadcom.com>

Add new compatible string for new version pwm-cygnus

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
index 8eae9fe..b224142 100644
--- a/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
+++ b/Documentation/devicetree/bindings/pwm/brcm,kona-pwm.txt
@@ -3,7 +3,7 @@ Broadcom Kona PWM controller device tree bindings
 This controller has 6 channels.
 
 Required Properties :
-- compatible: should contain "brcm,kona-pwm"
+- compatible: should contain "brcm,kona-pwm" or "brcm,cygnus-pwm"
 - reg: physical base address and length of the controller's registers
 - clocks: phandle + clock specifier pair for the external clock
 - #pwm-cells: Should be 3. See pwm.txt in this directory for a
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
