From: broonie@kernel.org (Mark Brown)
Date: Wed, 29 Aug 2018 16:26:56 +0100
Subject: [PATCH 1/2] ASoC: Add driver for PROTO Audio CODEC (with a WM8731)
In-Reply-To: <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
References: <20180829144727.13757-1-codrin.ciubotariu@microchip.com>
 <20180829144727.13757-2-codrin.ciubotariu@microchip.com>
 <20180829145355.GD27808@sirena.org.uk>
 <8f1ecff2-aab7-2a1d-a8d3-8d0062a8a9e0@microchip.com>
Message-ID: <20180829152656.GF27808@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 29, 2018 at 06:20:59PM +0300, Codrin Ciubotariu wrote:
> On 29.08.2018 17:53, Mark Brown wrote:

> > That also has the nice bonus that with that I think you'd be able to use
> > the graph card rather than a custom driver?

> The main reason for adding a custom driver and not using graph/simple card
> is the snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK_XTAL,
> XTAL_RATE, SND_SOC_CLOCK_IN) call. This enables the oscillator found in the
> wm8731 codec. Since WM8731_SYSCLK_XTAL is not 0, we can't use
> system-clock-frequency DT property to set it.

Right, that'd be more substantial surgery on the driver to change the DT
binding so that it's got a clock provider in it; it'd be nice to do but
it's a bit much to make it a blocker so the machine driver is OK.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180829/2d517a19/attachment.sig>
