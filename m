From: yegor_sub1@visionsystems.de (Yegor Yefremov)
Date: Thu, 03 Jun 2010 16:02:59 +0200
Subject: AC97 audio broken on SAM9263EK?
In-Reply-To: <4C07A422.5070505@atmel.com>
References: <4B85789D.6000704@billgatliff.com>
	<4B864C66.6060209@atmel.com>	<4B867108.2050806@billgatliff.com>
	<4B86AA29.8010806@atmel.com>	<4B89E1BB.6090504@billgatliff.com>
	<4B8B9849.5040203@atmel.com> <4B96571A.3040403@visionsystems.de>
	<4B96668E.6090805@atmel.com> <4B975C9A.3020106@visionsystems.de>
	<4B97602C.6070608@atmel.com> <4B97BD8C.3030502@visionsystems.de>
	<4B97C086.2080404@atmel.com> <4C050D97.4000404@visionsystems.de>
	<4C07A422.5070505@atmel.com>
Message-ID: <4C07B613.2040201@visionsystems.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sedji,

> It is an error indeed, it should be a debug message.

here is a patch:

atmel: set "channel A event" output to debug

Signed-off-by: Yegor Yefremov <yegorslists@googlemail.com>

Index: b/sound/atmel/ac97c.c
===================================================================
--- a/sound/atmel/ac97c.c	2010-06-01 15:28:23.000000000 +0200
+++ b/sound/atmel/ac97c.c	2010-06-03 15:20:43.000000000 +0200
@@ -657,7 +657,7 @@
 	if (sr & AC97C_SR_CAEVT) {
 		struct snd_pcm_runtime *runtime;
 		int offset, next_period, block_size;
-		dev_info(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
+		dev_dbg(&chip->pdev->dev, "channel A event%s%s%s%s%s%s\n",
 				casr & AC97C_CSR_OVRUN   ? " OVRUN"   : "",
 				casr & AC97C_CSR_RXRDY   ? " RXRDY"   : "",
 				casr & AC97C_CSR_UNRUN   ? " UNRUN"   : "",
