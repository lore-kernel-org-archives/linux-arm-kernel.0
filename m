From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Mar 2017 11:01:26 +0100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
References: <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
 <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
Message-ID: <20170327100126.osj3o2qtq4jwex3s@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 25, 2017 at 04:45:46PM +1100, Matt Flax wrote:
> On 25/03/17 06:09, Mark Brown wrote:

> > Could you please be concrete about what the two formats you're talking
> > about here are and how these differences are observable on the wire?  I
> > don't know what "two data word edge triggered ABP" means.
> On the codec side it is a regular TDM stream.
> On the SoC side, two channels  are arbitrarily offset from a PCM frame sync
> clock (PCM_FS) leading edge. I have chosen to have 64 bits per frame with 1
> bit offset for the first word (from the leading edge) and 33 bits offset
> (from the leading edge) for the second word. This resembles I2S, but it
> doesn't have to for the bcm2835.

What's internal to the SoC is not relevant here, what matters is what's
externally visible.  The formats on the DAI are how the SoC interfaces
with the outside world.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/b0422944/attachment.sig>
