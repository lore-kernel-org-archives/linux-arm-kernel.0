From: broonie@kernel.org (Mark Brown)
Date: Thu, 31 Dec 2015 22:19:35 +0000
Subject: [linux-sunxi] Re: [PATCH v8 2/2] ASoc: sun4i-codec: Add FM, Line
 and Mic inputs
In-Reply-To: <20151228040649.475a742f@dayas>
References: <20151221123148.1ab6480b@dayas> <20151221123416.51aa938e@dayas>
 <20151227182157.GI30359@lukather> <20151228040649.475a742f@dayas>
Message-ID: <20151231221935.GG16023@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 28, 2015 at 04:06:49AM +0100, Danny Milosavljevic wrote:
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> > > +static SOC_ENUM_SINGLE_DECL(sun4i_codec_enum_capture_source,
> > > +			    SUN4I_CODEC_ADC_ACTL,
> > > +			    SUN4I_CODEC_ADC_ACTL_ADCIS,
> > > +			    sun4i_codec_capture_source);

> > Isn't it possible to expose this as two (shared) muxes with different
> > names to make it clear what will go to the left ADC and what will go
> > to the right?

> I don't know how to do that. I'll try to find out.

> Can two muxes use the same bit in the hardware without problems?

IIRC we fixed things so that if you've got two controls that share the
same register we do the right thing.  There are other devices with this
issue but it was years ago that I last looked at them, we do have
handling.

> > Those are not volume it's gain, 

> We tried to call the things ..." Gain" before and it was difficult to do, 
> with some breakage along the way, see below.
> Also, Mark said they should be named ..." Volume" (see 
> <https://www.mail-archive.com/linux-sunxi@googlegroups.com/msg15126.html>).
> 
> >and it should probably be two different shared controls for mic1 and mic2.

Yes, this is part of the ABI and honestly from an end user point of view
there is no meaningful difference between the two words (there would be
more if it were gain and attenuation since one is amplification and the
other isn't so there are different considerations when applying them to
signals but that's not the case here).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151231/7b2cbdac/attachment.sig>
