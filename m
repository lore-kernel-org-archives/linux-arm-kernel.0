From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Mar 2012 19:18:12 +0000
Subject: [PATCH v3 09/11] ASoC: fsl: remove the fatal error checking on
 codec-handle
In-Reply-To: <4F62B941.5010306@freescale.com>
References: <20120313234638.GY3177@opensource.wolfsonmicro.com>
 <4F6008FA.3040805@freescale.com>
 <20120314122723.GC3133@opensource.wolfsonmicro.com>
 <4F612319.50302@freescale.com>
 <20120315142702.GL3138@opensource.wolfsonmicro.com>
 <4F621C60.5090700@freescale.com>
 <20120316020111.GE6065@S2101-09.ap.freescale.net>
 <4F62A06C.5000304@freescale.com>
 <20120316025219.GB7632@S2101-09.ap.freescale.net>
 <4F62B941.5010306@freescale.com>
Message-ID: <20120316191809.GG3158@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 16, 2012 at 03:53:39AM +0000, Tabi Timur-B04825 wrote:

> might be a way to general the call to platform_device_register_simple. 
> Maybe we could put "imx-pcm-audio" in the device tree?

We might end up doing that but as this adaption of the DMA controller to
the audio stack isn't really hardware so much as an implementation
detail of the audio stack it'd be nice to come up with some neater way
of doing it, ideally not involving the platform device at all.

I'm starting to think we should have a framework thing that lets DAI
drivers say they're a combined DMA/DAI driver for cases like this where
there is a generic DMA device that's being shared by lots of different
subsystems.  It's a common situation and it makes the device registration
clearer.  Adding Stephen Warren as he was thinking about this stuff in
the context of the nVidia drivers.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120316/e687354c/attachment.sig>
