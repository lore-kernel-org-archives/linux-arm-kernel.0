Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89835C5CFFE
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:01:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 55FAE2081F
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 22:01:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="gL3rSrim"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 55FAE2081F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ue3CEC24PeMdibBm9vQ0kCAgKYbeNg93loheE0oWbwI=; b=gL3rSrimvBEyTQ
	3Cj0KDLeSbyuwp9YdLlQk3APxnc+xhcSHRbCHxMric7AOZYXIJ0p4UAVUeLJAFO1A1Sv+coQhQhQE
	wQ17x+ngsHcv74fUtsBFMnyDLv0wWglncSDRZTFulecMk1hlqiOTs67F1pQC9mDq9iVusbpxfdhLc
	ofOjnUcTTMScDzGqy2Gg2eqzFSQ3j+O0nmcbfFiy0U18QaRe0wo9Za7WtVDWzMFJCv7XRhmP43mdl
	nrFov1qSYGPLNLoQAzu3m5Z04goqsxbc2+mCb8v/JuhciS+wh/8dezS5d0WHt/zFmnNZY0LgNScvt
	BBuQB6AYndaiWdMB4HbA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWTc0-0000Ze-M0; Mon, 10 Dec 2018 22:01:12 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWTbw-0000YZ-Tr
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 22:01:10 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue011 [212.227.15.129]) with ESMTPA (Nemesis) id
 1MDQRy-1gdb7r20LW-00AYJq; Mon, 10 Dec 2018 23:00:05 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org, Daniel Mack <daniel@zonque.org>,
 Haojian Zhuang <haojian.zhuang@gmail.com>,
 Robert Jarzmik <robert.jarzmik@free.fr>
Subject: [PATCH 4/4] ARM: pxa: avoid section mismatch warning
Date: Mon, 10 Dec 2018 22:58:39 +0100
Message-Id: <20181210215856.2238253-4-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210215856.2238253-1-arnd@arndb.de>
References: <20181210215856.2238253-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:op5fpHUg413BwkzBl40iq+Gi+V2I2A80rX9YvUBiIA3ewZpCu3+
 4BfpTBlnuSadxNlcNhoiRjVsPjHgrkdfa+hn29jiLca60B614GT8lwcVG2V6XNH3nQAfEJB
 C14/CzU1Ml/twPNzD8LGMwGGiAojrq3F5ZVSgzEEPkR0alfPoMYNrPOnNytDWbd7DTQ3iiY
 5zca4d+M+TCFXh6CVVTiA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:hrlG9Un2ALQ=:DCcryrPNDhf7kmYDcs4RXw
 TeC+J75xO8JdCPVmpVbrcVz/8vQ9KSkkMusgjGJAS1m8B6gjibqYNVoJhOXn+fV2/Q1cRvVYS
 pSlctY+MP/zF6zpTOaFRJckAc9wGAGq8rQE2l8lWYaWD1Xr7yoEUm+tx0BwBnWfwbg4MQFZT/
 oaa1VTtjv1pOIVdNgvBY0qOgvzv82Qwm+mAsj/HgpmsqtfaIr/7Ogw1M+lbD4sAgtkxG4IM6/
 P/yRMpMIF9NswmJ3C04NpEYnvatKb4v4m50TdVfnO38AoRuLd2u64n/DnD8NhPUVYuggu7+Sx
 Li43CdWd5AWRDEEewi0IYlJfRD3zBWFurRWtEA+9p5mTCiLPzAGWBPm4+wcCgyE/vVUs7nMG+
 WkE8pgVrevAYOHfLYFHp4vZN10fB3N50VuBCYnZN3qDyY1IeAKzITmY+WyLAjcTwHQZFu/Hpz
 18i8PD4BrJlYSsHif/fiWfGOzeBdCOSrnVJ/1XeU3cgSL4ZITceEtcy0DWUi4Ta9OIC3nBTve
 rtOUmQ3hGxvXzjjOSEYXWAi6/OQGsXuVehbHsEA34xHlshqiV0o91jG76dBCeTz89KoK1Ba/f
 oCXij6SUi8Wf7y2jYRLokrOb7qSNfUpAofEHV+QBz9enpYLuABWePi2X+okJzBDMYgQjyNANz
 cXH7b9EJCd5HRoLNgqjPRlyH744WtUauUO7lkZebDMAwJmGeXwEFXp4B/Aqqt68dMX2p/6xiA
 VLjLwlVhHIGYXWI8AaHeO4KTH0By0iVAMrEP+Q==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_140109_264827_C21AEA3A 
X-CRM114-Status: GOOD (  13.49  )
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
Cc: Ulf Hansson <ulf.hansson@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>, linux-kernel@vger.kernel.org,
 Igor Grinberg <grinberg@compulab.co.il>,
 Miquel Raynal <miquel.raynal@bootlin.com>,
 linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

WARNING: vmlinux.o(.text+0x19f90): Section mismatch in reference from the function littleton_init_lcd() to the function .init.text:pxa_set_fb_info()
The function littleton_init_lcd() references
the function __init pxa_set_fb_info().
This is often because littleton_init_lcd lacks a __init
annotation or the annotation of pxa_set_fb_info is wrong.

WARNING: vmlinux.o(.text+0xf824): Section mismatch in reference from the function zeus_register_ohci() to the function .init.text:pxa_set_ohci_info()
The function zeus_register_ohci() references
the function __init pxa_set_ohci_info().
This is often because zeus_register_ohci lacks a __init
annotation or the annotation of pxa_set_ohci_info is wrong.

WARNING: vmlinux.o(.text+0xf95c): Section mismatch in reference from the function cm_x300_init_u2d() to the function .init.text:pxa3xx_set_u2d_info()
The function cm_x300_init_u2d() references
the function __init pxa3xx_set_u2d_info().
This is often because cm_x300_init_u2d lacks a __init
annotation or the annotation of pxa3xx_set_u2d_info is wrong.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-pxa/cm-x300.c   | 2 +-
 arch/arm/mach-pxa/littleton.c | 2 +-
 arch/arm/mach-pxa/zeus.c      | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/arm/mach-pxa/cm-x300.c b/arch/arm/mach-pxa/cm-x300.c
index 109fab292f94..b76b566280fa 100644
--- a/arch/arm/mach-pxa/cm-x300.c
+++ b/arch/arm/mach-pxa/cm-x300.c
@@ -564,7 +564,7 @@ static struct pxa3xx_u2d_platform_data cm_x300_u2d_platform_data = {
 	.exit		= cm_x300_u2d_exit,
 };
 
-static void cm_x300_init_u2d(void)
+static void __init cm_x300_init_u2d(void)
 {
 	pxa3xx_set_u2d_info(&cm_x300_u2d_platform_data);
 }
diff --git a/arch/arm/mach-pxa/littleton.c b/arch/arm/mach-pxa/littleton.c
index 8e0b60a33026..39db4898dc4a 100644
--- a/arch/arm/mach-pxa/littleton.c
+++ b/arch/arm/mach-pxa/littleton.c
@@ -182,7 +182,7 @@ static struct pxafb_mach_info littleton_lcd_info = {
 	.lcd_conn		= LCD_COLOR_TFT_16BPP,
 };
 
-static void littleton_init_lcd(void)
+static void __init littleton_init_lcd(void)
 {
 	pxa_set_fb_info(NULL, &littleton_lcd_info);
 }
diff --git a/arch/arm/mach-pxa/zeus.c b/arch/arm/mach-pxa/zeus.c
index 897ef59fbe0c..c411f79d4cb5 100644
--- a/arch/arm/mach-pxa/zeus.c
+++ b/arch/arm/mach-pxa/zeus.c
@@ -576,7 +576,7 @@ static struct pxaohci_platform_data zeus_ohci_platform_data = {
 	.flags		= ENABLE_PORT_ALL | POWER_SENSE_LOW,
 };
 
-static void zeus_register_ohci(void)
+static void __init zeus_register_ohci(void)
 {
 	/* Port 2 is shared between host and client interface. */
 	UP2OCR = UP2OCR_HXOE | UP2OCR_HXS | UP2OCR_DMPDE | UP2OCR_DPPDE;
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
