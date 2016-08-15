From: broonie@kernel.org (Mark Brown)
Date: Mon, 15 Aug 2016 12:42:11 +0100
Subject: ASoC: sun4i-codec: playback stall and I/O error with DAPM paths
 all disabled
In-Reply-To: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
References: <CAGb2v66X2BhEM4X+zQHUFB-wpHuBQ4xc8ztfYFuKADnY0b-gaQ@mail.gmail.com>
Message-ID: <20160815114211.GI9347@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 15, 2016 at 05:43:55PM +0800, wens Tsai wrote:

> What is unexpected is any attempt to play anything under this state makes
> the playback software (in my case mpg321) stall, and later report an I/O
> error. My guess is that the DAC is still disabled by DAPM, so it doesn't
> send any DRQs, and thus the DMA engine is not consuming any data from
> userspace.

This is normal for ASoC - like you say it'll be becasue the hardware
isn't powered up.

> I think we should just enable the digital bits of the DAC/ADC all the
> time. Or maybe transfer and then discard data if the DAC is off. Not
> sure if this is doable though. I expect playback software to work, and
> not block, regardless of the hardware status.

Powering things up all the time will have a major effect on battery life
for systems that care about that.  The expectation is that systems with
this sort of hardware won't normally be offering end users direct
control of the routing, it'll be something that's handled during system
integration.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160815/63de4d34/attachment.sig>
