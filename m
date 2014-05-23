From: broonie@kernel.org (Mark Brown)
Date: Fri, 23 May 2014 12:05:44 +0100
Subject: [PATCH 2/2] ASoC: samsung: Add machine driver for odroidx2
In-Reply-To: <537F0A88.8000904@samsung.com>
References: <1400759708-25831-1-git-send-email-s.nawrocki@samsung.com>
 <1400759708-25831-2-git-send-email-s.nawrocki@samsung.com>
 <20140522185334.GT12304@sirena.org.uk>
 <537F0A88.8000904@samsung.com>
Message-ID: <20140523110544.GY12304@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 23, 2014 at 10:44:56AM +0200, Sylwester Nawrocki wrote:
> On 22/05/14 20:53, Mark Brown wrote:

> As for the DT binding documentation patch, I thought we're supposed to keep
> documentation in separate patches, so processes of separating it from the
> kernel is easier ?

I'm not sure what the current theory is - they should definitely be
separate if they're part of a multi-patch series but for a single patch
I don't remember what the current taste is.  If you're sending to the
same recipients anyway splitting isn't going to accomplish much, the
idea was to only send the DT binding to the DT maintainers and list and
not the code.

> >> +	ret = snd_soc_dai_set_sysclk(codec_dai, 3, MAX98090_MCLK_FREQ,
> >> +				     SND_SOC_CLOCK_IN);
> >> +	if (ret < 0) {
> >> +		dev_err(codec_dai->dev,
> >> +			"Unable to switch to FLL1: %d\n", ret);
> >> +		return ret;
> >> +	}

> > So's this - also what is 3?  Set it on init.

> OK, will move it. I'm not sure why 3, it seems to be ignored by the codec
> anyway. Chen, can you confirm the second argument is actually a don't care
> value ?

If it's don't care supply 0 instead.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140523/35883507/attachment.sig>
