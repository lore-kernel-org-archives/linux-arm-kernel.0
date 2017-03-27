From: broonie@kernel.org (Mark Brown)
Date: Mon, 27 Mar 2017 12:30:05 +0100
Subject: [alsa-devel] [PATCH 0/3] ASoC: Enable a new IC master mode:
 bcm2835<=>IC<=>cs42xx8
In-Reply-To: <289fc02f-4bdc-4bb7-6827-39c644816b70@flatmax.org>
References: <000fbaa4-4c7c-5b13-0806-7e42672a4a55@flatmax.org>
 <e0adcc6c-8bf4-adae-874b-c291e71e5712@laposte.net>
 <20170321221145.GA7258@camel2.lan>
 <579f0763-a5bd-f820-b36f-b6437e331b4b@flatmax.org>
 <20170322094301.GE6986@localhost.localdomain>
 <64802e9b-ffe9-65e3-502a-4253674fb4c7@flatmax.org>
 <20170324190955.nxw5az4mza2ia6wl@sirena.org.uk>
 <3c818d92-498e-868c-696b-a9b709af5415@flatmax.org>
 <20170327100126.osj3o2qtq4jwex3s@sirena.org.uk>
 <289fc02f-4bdc-4bb7-6827-39c644816b70@flatmax.org>
Message-ID: <20170327113005.czudkmmsrgs6isgk@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 27, 2017 at 09:35:33PM +1100, Matt Flax wrote:

> In this case, there is the TDM (DSP mode) protocol on the Codec. The SoC
> however is communicating in channel pairs {{0, 1}, {2, 3}, {4, 5}, {6, 7}}.
> Each channel separated by the PCM_FS clk leading edge.

> As far as the codec is concerned it is DSP mode. As far as the SoC is
> concerned, it is not I2S, nor is it strictly DSP mode because there is more
> then one PCM_FS per frame !

> If we look at this from the perspective of the Codec, then it is DSP mode. I
> am just not sure what to call the SoC's protocol, other then multi-paired
> PCM.

This isn't DSP mode from anything's point of view, the extra frame syncs
mean it's a whole new format.  Off the top of my head I'd suggest just
running it as stereo DSP mode from a kernel point of view and fixing
things up in userspace.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170327/0d7f419f/attachment.sig>
