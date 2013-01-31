From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 31 Jan 2013 10:32:25 +0800
Subject: [PATCH 1/2] ASoC: tlv320aic3x: Convert mic bias to a supply widget
In-Reply-To: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
References: <1359552155-17426-1-git-send-email-gururaja.hebbar@ti.com>
Message-ID: <20130131023221.GA6027@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 30, 2013 at 06:52:35PM +0530, Hebbar Gururaja wrote:

> Convert MicBias widgets to supply widget.

> On tlv320aic3x, Mic bias power on/off shares the same register bits
> with output mic bias voltage.  So, when power on mic bias, we need
> reclaim it to voltage value.

This should update machine drivers that use the CODEC too.

> +- ai3x-micbias-vg - MicBias Voltage required.
> +	1 - MICBIAS output is powered to 2.0V,
> +	2 - MICBIAS output is powered to 2.5V,
> +	3 - MICBIAS output is connected to AVDD,
> +	If this node is not mentioned or if the value is incorrect, then MicBias
> +	is powered down.

Would 2.0V not be a more sensible default (it is the lowest voltage so
is unlikely to cause hardware damage if it's wrong)?

Otherwise this looks good.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130131/c8628dbd/attachment.sig>
