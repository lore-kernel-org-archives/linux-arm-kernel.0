From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 17:38:54 +0000
Subject: [PATCH 5/5] ASoC: dwc: Ensure FIFOs are flushed to prevent
 channel swap
In-Reply-To: <547F3CB2.5070306@arm.com>
References: <547F3CB2.5070306@arm.com>
Message-ID: <20141203173854.GE7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 04:39:14PM +0000, Andrew Jackson wrote:
> If the FIFOs aren't flushed, the left/right channels may be swapped:
> this may occur if the FIFOs are not empty when the streams start.

>  	/* Iterate over set of channels - independently controlled. */
>  	do {
>  		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
> +			i2s_write_reg(dev->i2s_base, TXFFR, 1);

This is an example of the problem with putting fixes at the end of the
series - this can't be applied without your previous change to add the
support for more channels (which is a new feature).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/ea3a129a/attachment.sig>
