From: broonie@kernel.org (Mark Brown)
Date: Mon, 5 Aug 2013 12:27:33 +0100
Subject: [PATCH RFC 10/13] ASoC: kirkwood-t5325: add DAPM links between
 codec and cpu DAI
In-Reply-To: <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
References: <20130804192136.GK23006@n2100.arm.linux.org.uk>
 <E1V641A-0004lv-DM@rmk-PC.arm.linux.org.uk>
Message-ID: <20130805112733.GY9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 04, 2013 at 08:31:04PM +0100, Russell King wrote:
> Add the DAPM links to connect the codec DAC and ADCs to the cpu DAI
> I2S inputs/outputs.

> +	{ "i2sdi",		NULL,	"Capture" },
> +	{ "Playback",		NULL,	"i2sdo" },

This doesn't look good - this is adding DAPM routes which should
correspond to the DAI link that's already been configured.  This isn't
something we should have to add to the machine driver, if the machine
driver already set up a dai_link then these things should already be
taken care of one way or another.  Either links like this get added or
the DAIs get kicked at runtime as part of the link startup.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130805/22e8555a/attachment.sig>
