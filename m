From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 1 Sep 2016 18:45:01 +0200
Subject: [linux-sunxi] Re: [PATCH v9 1/2] ASoC: sun4i-codec: Distinguish
 sun4i from sun7i
In-Reply-To: <20160831221402.670ab832@scratchpost.org>
References: <20160830054403.7878-1-dannym@scratchpost.org>
 <20160830054403.7878-2-dannym@scratchpost.org>
 <20160831174623.GA20462@lukather>
 <20160831221402.670ab832@scratchpost.org>
Message-ID: <20160901164501.GE20462@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Danny,

On Wed, Aug 31, 2016 at 10:14:02PM +0200, Danny Milosavljevic wrote:
> Hi Maxime,
> 
> On Wed, 31 Aug 2016 19:46:23 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > -#define SUN4I_CODEC_AC_SYS_VERI			(0x38)
> > > -#define SUN4I_CODEC_AC_MIC_PHONE_CAL		(0x3c)
> > > +
> > > +#define SUN7I_CODEC_AC_DAC_CAL			(0x38)
> > > +#define SUN7I_CODEC_AC_MIC_PHONE_CAL		(0x3c)  
> > 
> > That will need at least some mention in the commit log.
> 
> Hm? It's now called like it is called in the user manual.
> Also, the macro SUN4I_CODEC_AC_SYS_VERI was unused before anyway.
> 
> What should I write in the commit log?

For example, that the current code was wrong and those registers are
not present on the A10.

That way, you justify both the renaming, and the max_register change
in the regmap.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160901/196be5c1/attachment.sig>
