From: broonie@kernel.org (Mark Brown)
Date: Wed, 7 Oct 2015 10:39:40 +0100
Subject: [PATCH 1/2] ASoC: rockchip: i2s: add 8 channels capture and
 lrck-mode support
In-Reply-To: <20151007092714.GZ12635@sirena.org.uk>
References: <1442979683-9441-1-git-send-email-sugar.zhang@rock-chips.com>
 <1442979683-9441-2-git-send-email-sugar.zhang@rock-chips.com>
 <20150923162433.GQ30445@sirena.org.uk>
 <5608F74C.3000104@rock-chips.com>
 <20150930184655.GX15635@sirena.org.uk>
 <5614D162.3020500@rock-chips.com>
 <20151007092714.GZ12635@sirena.org.uk>
Message-ID: <20151007093940.GA12635@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 10:27:14AM +0100, Mark Brown wrote:
> On Wed, Oct 07, 2015 at 04:01:38PM +0800, sugar wrote:

> > if (dai->symmetric_rates)
> > 	regmap_update_bits(i2s->regmap, I2S_CKR,
> >                            I2S_CKR_TRCM_MASK,
> >                            I2S_CKR_TRCM(val));

> Yes, something like that.  You'll need to check both links in the DAI
> and the DAI link itself rather than just your own DAI but we should have
> a helper function for that - I'll add one, look out for a patch shortly.

Actually no, now I look at the code you probably want to just clone the
check from soc_pcm_apply_symmetry() so have that be:

	struct snd_soc_pcm_runtime *rtd = substream->private_data;

	if (rtd->dai_link->symmetrict_rates) {
	}

instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151007/6fca16fa/attachment.sig>
