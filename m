Return-Path: <SRS0=DN+v=OP=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730F4C04EB8
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:45 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C80A20892
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu,  6 Dec 2018 18:30:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="iDbsRb3X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2C80A20892
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=i2se.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=AkoikDyore70f2ZldSEgv5XZG+Q9L1Y96b70fKGS3SE=; b=iDbsRb3Xdn/FRodKnpZfSbAv37
	uW5oCZPtlzKX57sTM5IFsm+G1YKwCuja/1aB9Dr0g/zhkTAY4Zta8kOqAerwSILzBismLCuW3R2TQ
	7Qj6SHgDg6D/II+Ok7OzXWgzh3Y7fsUwK6FzH402ZD4YoArsbxhPJrR+aq/uvm/FoKugmrhOoHkXI
	3UkP/xhVZp3TEYButtsI1Ca/VprKRvFLtj5U7yDUU5QMqtiYlFUraIGR6XrbffvlpYKjsCCX0mLlK
	NdgQZtxisCAjyV8/vAWlOX1r5gux1++GhoLRllRv8GyLtYMiXmMCB4LG32vylitbQ4OLLkfAOQuaf
	lhb5MMmA==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gUyQ1-00075r-1a; Thu, 06 Dec 2018 18:30:37 +0000
Received: from mout.kundenserver.de ([212.227.126.135])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gUyOu-0004oo-Sj
 for linux-arm-kernel@lists.infradead.org; Thu, 06 Dec 2018 18:29:32 +0000
Received: from localhost.localdomain ([37.4.249.153]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M4384-1gUyOb1hxI-0007R8; Thu, 06 Dec 2018 19:29:09 +0100
From: Stefan Wahren <stefan.wahren@i2se.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 08/10] staging: bcm2835-audio: Drop DT dependency
Date: Thu,  6 Dec 2018 19:28:58 +0100
Message-Id: <1544120940-13716-9-git-send-email-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
References: <1544120940-13716-1-git-send-email-stefan.wahren@i2se.com>
X-Provags-ID: V03:K1:g3/xPB2IGZVn+TfoSW6YeKqg/QZWyo3+WnfD5hMil16XKJT8KQi
 ZnWxlb9dCq5D6jfzCupxInfvIt1pUOWL9/pZmLG+hxnT9W10AlGf8twztuLpLuTACbMeNAc
 GY5m6/Z3ryJR0gqgwm5c6p2LVZ6y9a2VHAN8YFhhY9mNvb6BTgPtRxsSzNKAnlCnj0UWsX5
 s8vc4OnI5VjtEOOKgVLGw==
X-UI-Out-Filterresults: notjunk:1;V03:K0:0iYxVdPIVdk=:HAlGrHHchaRyyrfjyGwlYb
 oPeYsCuJmPYI1bNk1zUezvTfjOY28UtFbhg1ztPSyv8FvLYdn6PQnL5tAByiqICb8QeQNLLl8
 0JDJavX3eo/Sh5hNCgh3oEr9peNhNEd0tPxszrfdncXZQ5i24J2KGGvqPdQbSeZ0vcwoQPnSu
 K0uACd/Xlavb+0sJ7xbILK/r371T9WuluAaygeCudjYOcd9GVDTVEm25IautVI575AGJHBJuy
 hKI9dO2Pz3iZR3aDo30ey1cZxbI4SsZfJo/Ki1+BsnFzH1TLNXWGmk9PexKPHcQ+Nqw5aH0Gh
 tml77k2Ch4dZlTQMZvpe4RP8SBFZN8NVAPATGNbvrbodJ7BRcm8Z/iWF1hsV+0p4s/75qlxI6
 vwfT3wSdKPbWGmSEeJfCDl43FGJRL0Z4YKhcAuJ/PQRGcBNlxjbBJ/+49GgxsPpfug8gE4VNk
 97S5hfsHC/01DErNIM96HuWRC/gtLWtT4fyGGO2skHvyolLbZ4KRCzY0QPeble0xJ0fLDEEUw
 8KI8fDr4ZjCWwpdzIkerx4vHHwptIyHUWkGcF3qx50SEJeZX4mDacG9SFcYb7UidwBcqSUeVg
 gayfQwvNQtitliyy6HTtLbrQiLtNu45y7WPqFaCpioNhMNn3NL3iyyWIOf2vgYrdH7F5kWBR5
 7KMQRGCQUUuKDFQNPYbTXXoOzWPBYFuJfMU621HNDjOXQyNwIRRER6CR8KPMRRLzCZ+EjQ+ZN
 6h7kKjZ98di8DoS1q/yCvrEyg4xN/WqxPbkUukqBtndxGAhulwFrbdFtvL4=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181206_102929_300727_3B98F1C8 
X-CRM114-Status: GOOD (  14.90  )
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
Cc: devel@driverdev.osuosl.org, Stefan Wahren <stefan.wahren@i2se.com>,
 Takashi Iwai <tiwai@suse.de>, Eric Anholt <eric@anholt.net>,
 linux-arm-kernel@lists.infradead.org,
 Dave Stevenson <dave.stevenson@raspberrypi.org>,
 Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

Just like the bcm2835-video make this a platform driver which is probed
by vchiq. In order to change the number of channels use a module
parameter instead, but use the maximum as default.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Nicolas Saenz Julienne <nsaenzjulienne@suse.de>
---
 .../staging/vc04_services/bcm2835-audio/bcm2835.c  | 31 +++++++---------------
 1 file changed, 9 insertions(+), 22 deletions(-)

diff --git a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
index 86b9210..cf5f80f 100644
--- a/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
+++ b/drivers/staging/vc04_services/bcm2835-audio/bcm2835.c
@@ -6,13 +6,13 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/module.h>
-#include <linux/of.h>
 
 #include "bcm2835.h"
 
 static bool enable_hdmi;
 static bool enable_headphones;
 static bool enable_compat_alsa = true;
+static int num_channels = MAX_SUBSTREAMS;
 
 module_param(enable_hdmi, bool, 0444);
 MODULE_PARM_DESC(enable_hdmi, "Enables HDMI virtual audio device");
@@ -21,6 +21,8 @@ MODULE_PARM_DESC(enable_headphones, "Enables Headphones virtual audio device");
 module_param(enable_compat_alsa, bool, 0444);
 MODULE_PARM_DESC(enable_compat_alsa,
 		 "Enables ALSA compatibility virtual audio device");
+module_param(num_channels, int, 0644);
+MODULE_PARM_DESC(num_channels, "Number of audio channels (default: 8)");
 
 static void bcm2835_devm_free_vchi_ctx(struct device *dev, void *res)
 {
@@ -294,28 +296,19 @@ static int snd_add_child_devices(struct device *device, u32 numchans)
 static int snd_bcm2835_alsa_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
-	u32 numchans;
 	int err;
 
-	err = of_property_read_u32(dev->of_node, "brcm,pwm-channels",
-				   &numchans);
-	if (err) {
-		dev_err(dev, "Failed to get DT property 'brcm,pwm-channels'");
-		return err;
-	}
-
-	if (numchans == 0 || numchans > MAX_SUBSTREAMS) {
-		numchans = MAX_SUBSTREAMS;
-		dev_warn(dev,
-			 "Illegal 'brcm,pwm-channels' value, will use %u\n",
-			 numchans);
+	if (num_channels <= 0 || num_channels > MAX_SUBSTREAMS) {
+		num_channels = MAX_SUBSTREAMS;
+		dev_warn(dev, "Illegal num_channels value, will use %u\n",
+			 num_channels);
 	}
 
 	err = bcm2835_devm_add_vchi_ctx(dev);
 	if (err)
 		return err;
 
-	err = snd_add_child_devices(dev, numchans);
+	err = snd_add_child_devices(dev, num_channels);
 	if (err)
 		return err;
 
@@ -337,12 +330,6 @@ static int snd_bcm2835_alsa_resume(struct platform_device *pdev)
 
 #endif
 
-static const struct of_device_id snd_bcm2835_of_match_table[] = {
-	{ .compatible = "brcm,bcm2835-audio",},
-	{},
-};
-MODULE_DEVICE_TABLE(of, snd_bcm2835_of_match_table);
-
 static struct platform_driver bcm2835_alsa_driver = {
 	.probe = snd_bcm2835_alsa_probe,
 #ifdef CONFIG_PM
@@ -351,7 +338,6 @@ static struct platform_driver bcm2835_alsa_driver = {
 #endif
 	.driver = {
 		.name = "bcm2835_audio",
-		.of_match_table = snd_bcm2835_of_match_table,
 	},
 };
 module_platform_driver(bcm2835_alsa_driver);
@@ -359,3 +345,4 @@ module_platform_driver(bcm2835_alsa_driver);
 MODULE_AUTHOR("Dom Cobley");
 MODULE_DESCRIPTION("Alsa driver for BCM2835 chip");
 MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:bcm2835_audio");
-- 
2.7.4


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
