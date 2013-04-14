From: timur@tabi.org (Timur Tabi)
Date: Sun, 14 Apr 2013 10:25:49 -0500
Subject: [PATCH v2 05/11] ASoC: fsl-ssi: Add support for imx-pcm-fiq
In-Reply-To: <20130414152016.GE27394@pengutronix.de>
References: <1365362721-3731-1-git-send-email-mpa@pengutronix.de>
 <1365362721-3731-6-git-send-email-mpa@pengutronix.de>
 <51620CEA.3010703@tabi.org> <20130414103819.GA27394@pengutronix.de>
 <516AB111.3000007@tabi.org> <20130414141015.GC27394@pengutronix.de>
 <516AC305.2000800@tabi.org> <20130414152016.GE27394@pengutronix.de>
Message-ID: <516ACA7D.60807@tabi.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Markus Pargmann wrote:
> I only ported the imx-ssi ac97 driver code and tested twice using DMA
> without success. But there is a good description of the problem in
> imx-ssi:
>
> " The WM9712 with which this driver
> was developed with always sends GPIO status data in slot 12 which
> we receive in our (PCM-) data stream. The only chance we have is to
> manually skip this data in the FIQ handler."

Ah, so this is a work-around for a bug, where the codec is incompatible 
with the SoC?  Mark, are you familiar with this issue?  Is there a way to 
reconfigure the codec so that it works better with the SoC?  It seems 
ridiculous to add all this code just because an incompatible codec was 
chosen for some board.

Either way, the board DTS needs to clearly state *why* we're enabling FIQ 
mode when DMA mode should work.  And the patch that adds FIQ support needs 
to say that it's for boards with broken DMA support.

-- 
Timur Tabi
