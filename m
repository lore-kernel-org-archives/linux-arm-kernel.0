Return-Path: <SRS0=/awj=OT=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97D9FC04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6256D20821
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Mon, 10 Dec 2018 20:44:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="YgSM6evT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6256D20821
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=arndb.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=cAItDysPTnP1EdMT8w4wiB5Bko/sbUOkEGW1qHDj404=; b=YgSM6evT5Bl9hd
	H8hTLfIzjtqdtEhXgRsL9i4Z48ikoaw2DqiWCxDi1oZyRZQ+gczKPe9WCUNU1S6N5bBcgGw+OVFyo
	vrlnKgOhtLGwx18LraStQyWl0sJXuAv35B3W4ElwduKf41MeQ4nimR8w8qeTaJT++00EyOZwr3dxq
	bntqITkEHRA+fSARGswiuwp0MlT0bMMXY0sjbL8T5ppISseuGqBXZG+n8p3hSq7IBR2uNL8KieA7T
	tQhKncURSQuhUjxut73Nr9kt2ZxMHkcukiDIvwW+wjTbdr/XqtS7WLydrEWYDBD5bXtVTZuhQrMT/
	oA5NOgP1XhDBm2zsjUDw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gWSPf-0007LN-8n; Mon, 10 Dec 2018 20:44:23 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gWSPX-000710-Pd
 for linux-arm-kernel@lists.infradead.org; Mon, 10 Dec 2018 20:44:18 +0000
Received: from wuerfel.lan ([109.192.41.194]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.145]) with ESMTPA (Nemesis) id
 1Mz9EL-1hR9vT0bkR-00wE1f; Mon, 10 Dec 2018 21:44:04 +0100
From: Arnd Bergmann <arnd@arndb.de>
To: arm@kernel.org,
	Lubomir Rintel <lkundrak@v3.sk>
Subject: [PATCH 2/2] ARM: mmp: fix pxa168_device_usb_phy use on aspenite
Date: Mon, 10 Dec 2018 21:43:02 +0100
Message-Id: <20181210204340.2269622-2-arnd@arndb.de>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20181210204340.2269622-1-arnd@arndb.de>
References: <20181210204340.2269622-1-arnd@arndb.de>
MIME-Version: 1.0
X-Provags-ID: V03:K1:066X8609S8rRazQMCxM0FQnLP8YBYE3tBO/JFQU/o9qGK62sZEZ
 qnkHhV6WydiLmZjK6EPxbr7ntdTB1Hjf2f+DRGjcZ29jjc4BbT2kLtOiYiOKR1WEdO53qVD
 BD5c+EyteTSOTmrfUA1RcosJq+JwInpv7Nxp9SlKAIjQ8cgUjIauG7s8oDiuyx2ArM5OKmD
 /3SwebMridHGZxB4OmrwQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Al2IwXHE/Ao=:OWxv5MAfZta7Ray7LT/eCZ
 DWOeYtzaektrlbfMIsguch7FKeGQeBBSrQQg+GUmYuGmoy85WzZKmsdR2RSYiZ0orgV1YynkS
 kFMXBH0OcI0mlexGgcHWsArbQuubbvwtTuZMxgk0A6yF9aY5kAS7fcbrHcQRhBhbH6SQd6xSg
 I4GWBul94I5vhz4zFIUHyQHBhAMg7xQ/MBSnbRN3r44x6W8rv5+C0ziUPcp/UaOFrH8suJ7AQ
 OmTFFZXiqy7fTvMYEmOP9qcHrOkRRrUy1jPfgxyPH4+6jg9aLP4Y2Pb8e8tnbZUGe6+C6fk2H
 vGK4dxbff4AgLesJgLnEQEg8dClRQXmeYENMisCiYVPOkrXP7AS3GWiFnl9WAi27AJ7XiHSJ1
 XWDOqBnfX69fNKPtYedDnwOHCgXYUm9bt4QeuNKELBaRZfWM1pwoJEmwKt/e3TCxksvUYrT+Y
 BNAJJb6SEvy2767vciVaLaUrd/AeNngECLzFRMdqh2cbg8WRStpKWBtU6m8Q1RKCmJzULSU8H
 X0emm/aZQfmgt1dbtuNA9dB3m5BWLqtFquEms6iIQs8yBp8Cw98lLFci/DNb5tP0i/9n2s/ju
 W2i1c4TkjI2E02eKaMj1MUfmkvGBRw/6K2YAUyAiy8wLoko7dgD5THSCIQzYbkrQzAsTS/iL/
 TXUHTcnT46CvemYhMdVv0A0RCMHKiA2iTxbJ86B0KrZM3Gnyi1SMvKWwq3+FDQ+6cevGsDli8
 CAsolcFHCXWDjb781orIRecfTpbbtY9FJ+SrTQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181210_124416_136521_ACC6F699 
X-CRM114-Status: GOOD (  11.95  )
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
Cc: linux-arm-kernel@lists.infradead.org, Arnd Bergmann <arnd@arndb.de>,
 linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

This one ended up in the wrong header file, causing a build failure
on at least one platform:

arch/arm/mach-mmp/aspenite.c: In function 'common_init':
arch/arm/mach-mmp/aspenite.c:260:28: error: 'pxa168_device_usb_phy' undeclared (first use in this function); did you mean 'pxa168_device_ssp5'?

We can just include both the pxa168.h and pxa910.h headers to make
that work, which gets us to the next failure:

arch/arm/mach-mmp/aspenite.o: In function `common_init':
aspenite.c:(.init.text+0x1c0): undefined reference to `pxa168_device_usb_phy'

This is solved by using the matching ifdef check around the
USB device registration, enabling them only when either USB
host or gadget mode are enabled.

Fixes: a225daf72ee7 ("ARM: mmp: add a pxa-usb-phy device")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/arm/mach-mmp/aspenite.c | 3 +++
 arch/arm/mach-mmp/ttc_dkb.c  | 2 ++
 2 files changed, 5 insertions(+)

diff --git a/arch/arm/mach-mmp/aspenite.c b/arch/arm/mach-mmp/aspenite.c
index 23f99976b5f5..75b2d7db643e 100644
--- a/arch/arm/mach-mmp/aspenite.c
+++ b/arch/arm/mach-mmp/aspenite.c
@@ -29,6 +29,7 @@
 #include "addr-map.h"
 #include "mfp-pxa168.h"
 #include "pxa168.h"
+#include "pxa910.h"
 #include "irqs.h"
 #include "common.h"
 
@@ -256,6 +257,7 @@ static void __init common_init(void)
 	/* off-chip devices */
 	platform_device_register(&smc91x_device);
 
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
 #if IS_ENABLED(CONFIG_PHY_PXA_USB)
 	platform_device_register(&pxa168_device_usb_phy);
 #endif
@@ -263,6 +265,7 @@ static void __init common_init(void)
 #if IS_ENABLED(CONFIG_USB_EHCI_MV)
 	pxa168_add_usb_host(&pxa168_sph_pdata);
 #endif
+#endif
 }
 
 MACHINE_START(ASPENITE, "PXA168-based Aspenite Development Platform")
diff --git a/arch/arm/mach-mmp/ttc_dkb.c b/arch/arm/mach-mmp/ttc_dkb.c
index 767dcb23ee1c..09b53ace08ac 100644
--- a/arch/arm/mach-mmp/ttc_dkb.c
+++ b/arch/arm/mach-mmp/ttc_dkb.c
@@ -282,6 +282,7 @@ static void __init ttc_dkb_init(void)
 				 sizeof(struct pxa_gpio_platform_data));
 	platform_add_devices(ARRAY_AND_SIZE(ttc_dkb_devices));
 
+#if IS_ENABLED(CONFIG_USB_SUPPORT)
 #if IS_ENABLED(CONFIG_PHY_PXA_USB)
 	platform_device_register(&pxa168_device_usb_phy);
 #endif
@@ -300,6 +301,7 @@ static void __init ttc_dkb_init(void)
 	pxa168_device_u2ootg.dev.platform_data = &ttc_usb_pdata;
 	platform_device_register(&pxa168_device_u2ootg);
 #endif
+#endif
 
 #if IS_ENABLED(CONFIG_MMP_DISP)
 	add_disp();
-- 
2.20.0


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
