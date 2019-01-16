Return-Path: <SRS0=Ql45=PY=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28750C43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:16:18 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E0FBF20840
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Wed, 16 Jan 2019 20:16:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="LU1eCsBf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="DgTDQ2Y0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E0FBF20840
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=rniatBEhjwTkf5Sa4UpXVJUXj8E7w3zliwt6B7J1P64=; b=LU1eCsBfNFMxD2xiYRc9GUUav4
	btWi9SNMST7UAwcn1kfw0PsWOIa5+hwG5AZKvpYQfHTp6cA2PGpPoiGO4lxmYoMQdzb32RoXlAuHB
	XL0Cpm/2beGwmmD7/M+AMpReARxmv7F4K6oxssemefIhhuP6J2GkaxXKzogjm/6l8M9h72zD3IUDA
	NoTmpt11iz8XTrlV1bMZC3nmaoLhv3nXEMJdhzvm68QOhMR8QWVFKZ6wQ021UGGSR76c6oCp0hH4f
	bKnnTkUUBGpQGTzfZDTuALc92k4sv+i7aAZ9lWF229qCaU1Nw9SZlIfDbg8AZMbliueY1CwhAmKWF
	XH4VHzMg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gjrbf-0005RZ-4R; Wed, 16 Jan 2019 20:16:11 +0000
Received: from mail-yw1-xc41.google.com ([2607:f8b0:4864:20::c41])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gjrah-0003Yz-3P
 for linux-arm-kernel@lists.infradead.org; Wed, 16 Jan 2019 20:15:17 +0000
Received: by mail-yw1-xc41.google.com with SMTP id b63so2919393ywc.11
 for <linux-arm-kernel@lists.infradead.org>;
 Wed, 16 Jan 2019 12:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ffaxKx8sodfXLl/Ae5Fx/GunKh8JaBz2jFEkjCzH1IA=;
 b=DgTDQ2Y0IsxBDo5xlkskqj1A2nFOd9YLpXJzXlBQKltATqy6Tcf5qO8TSAjRfE+p7Y
 Jf2bTIjO7U9Pjej1nGrTyRhKWM7YxTXVwWAl9rT7AobVB5z0yxgnYzLtGB/Ck2/e9w6B
 EiWqCBb6tq5W9IFz/HbwyfOBHOkmkQZRW6Aq0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ffaxKx8sodfXLl/Ae5Fx/GunKh8JaBz2jFEkjCzH1IA=;
 b=uOoJY0H0Z58h+Rrek1p9k7d/eiMUgSKib1bmJZo9RNel/QUnk2sKvdV4yU78YAJd8J
 oVPre8Unmk0qhrY1vQ6AIJyGUsUQ57gvz7AoUvZO5oUSMZX1couJcf+0TEEnBm7zrfFE
 hdNXfW9756MZb5h7rPGFaKf0RjcqrXdyC3pcJO4Bs/Er4RdP/cFdiIIPNw3XXInqfOYh
 sw9TAxElNJCRbBiwZWQJZTorlSe2OQMzTQkibIvdLd/eMDvl/1yNDil5YeIFT87kBzRe
 GlBGJtNCe8L2nC5kavEfGITVM/dOTxGrdjzH50JofXeNTZaZziH00/xJ9SgYR9QMopNz
 +Wjw==
X-Gm-Message-State: AJcUukfBAoJkYFzpdcZgsAsXykfGoLeIPo4FB3Ha6fFc2nVzADcf7nlU
 uLaUwJLNiY0czYsU529qhuh9iw==
X-Google-Smtp-Source: ALg8bN7vBkQr02Su0vaWXmLOZSm1JT1r23yhisXUBqeoJFY5Xs7r71YBS9BQPKq3yH6tnoZXPBLLgQ==
X-Received: by 2002:a0d:e0c5:: with SMTP id j188mr9769018ywe.164.1547669710159; 
 Wed, 16 Jan 2019 12:15:10 -0800 (PST)
Received: from shitalt.dhcp.broadcom.net ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id w63sm2541026ywc.46.2019.01.16.12.15.05
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
 Wed, 16 Jan 2019 12:15:09 -0800 (PST)
From: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
To: Thierry Reding <thierry.reding@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Florian Fainelli <f.fainelli@gmail.com>, Ray Jui <rjui@broadcom.com>,
 Scott Branden <sbranden@broadcom.com>
Subject: [PATCH V2 4/4] ARM: dts: cygnus: Change pwm compatible to new version
Date: Thu, 17 Jan 2019 01:45:16 +0530
Message-Id: <1547669716-20070-5-git-send-email-sheetal.tigadoli@broadcom.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
References: <1547669716-20070-1-git-send-email-sheetal.tigadoli@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190116_121513_702424_6A41BA49 
X-CRM114-Status: GOOD (  15.06  )
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

Change pwm compatible to new version pwm-cygnus
Add new compatible to check pwm configure status

Signed-off-by: Praveen Kumar B <praveen.b@broadcom.com>
Reviewed-by: Ray Jui <ray.jui@broadcom.com>
Reviewed-by: Scott Branden <scott.branden@broadcom.com>
Signed-off-by: Sheetal Tigadoli <sheetal.tigadoli@broadcom.com>
---
 arch/arm/boot/dts/bcm-cygnus.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/bcm-cygnus.dtsi b/arch/arm/boot/dts/bcm-cygnus.dtsi
index 253df71..0a0ec5b 100644
--- a/arch/arm/boot/dts/bcm-cygnus.dtsi
+++ b/arch/arm/boot/dts/bcm-cygnus.dtsi
@@ -595,7 +595,7 @@
 		};
 
 		pwm: pwm@180aa500 {
-			compatible = "brcm,kona-pwm";
+			compatible = "brcm,cygnus-pwm";
 			reg = <0x180aa500 0xc4>;
 			#pwm-cells = <3>;
 			clocks = <&asiu_clks BCM_CYGNUS_ASIU_PWM_CLK>;
-- 
1.9.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
