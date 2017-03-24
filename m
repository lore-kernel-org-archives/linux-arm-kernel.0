From: broonie@kernel.org (Mark Brown)
Date: Fri, 24 Mar 2017 19:11:59 +0000
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <1bec6abc-c296-eb93-a096-e4b8f1c7e1a4@wwwdotorg.org>
References: <20170315190108.y6ybxm3nfgnutajv@sirena.org.uk>
 <7d8d38f7-53aa-cc3d-4bbd-141649528a8a@flatmax.org>
 <8c62f014-d246-e0c1-2b02-a28a2c2786b7@metafoo.de>
 <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <1bec6abc-c296-eb93-a096-e4b8f1c7e1a4@wwwdotorg.org>
Message-ID: <20170324191159.wyikevxc7dmvkaup@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 22, 2017 at 09:38:28AM -0600, Stephen Warren wrote:

> Now the BCM2835 I2S controller does appear to have a few features beyond
> plain I2S/DSP modes, that not all I2S controllers might have, such as:

> - Frame length, FS length, channel position, and channel width are specified
> at bit resolution rather than byte/sample/...

> - PDM mode (for digital mics).

> - Sign extension of RX data.

> So, the controller can generate/receive some formats beyond plain I2S/DSP,
> but to be honest I doubt that this level of detail needs to be exposed to
> the ALSA/ASoC core or user-space, nor is it required to interface to any
> typical HW, so it can be hidden in the driver's register programming
> implementation.

At the minute the driver doesn't even support these features, it just
supports plain stereo I2S mode and it *may* be that all that's needed
here is the addition of the DSP modes.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170324/1c926b42/attachment.sig>
