From: dannym@scratchpost.org (Danny Milosavljevic)
Date: Wed, 31 Aug 2016 22:14:02 +0200
Subject: [linux-sunxi] Re: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish
 sun4i from sun7i
In-Reply-To: <20160831174623.GA20462@lukather>
References: <20160830054403.7878-1-dannym@scratchpost.org>
 <20160830054403.7878-2-dannym@scratchpost.org>
 <20160831174623.GA20462@lukather>
Message-ID: <20160831221402.670ab832@scratchpost.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Wed, 31 Aug 2016 19:46:23 +0200
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > -#define SUN4I_CODEC_AC_SYS_VERI			(0x38)
> > -#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
> > +
> > +#define SUN7I_CODEC_AC_DAC_CAL			(0x38)
> > +#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)  
> 
> That will need at least some mention in the commit log.

Hm? It's now called like it is called in the user manual.
Also, the macro SUN4I_CODEC_AC_SYS_VERI was unused before anyway.

What should I write in the commit log?

> It would be better to add a structure assiocated to the data field of
> of_device_id. That way, you'll also be able to have any quirks without
> adding more checks (such as a different regmap config, like Chen-Yu
> suggested).

Yeah, I did that now; seems to work.

Cheers,
   Danny
