From: moinejf@free.fr (Jean-Francois Moine)
Date: Wed, 13 Jan 2016 18:37:30 +0100
Subject: [PATCH RFC 2/2] drm: sunxi: Add a basic DRM driver for
 Allwinner DE2
In-Reply-To: <568D7BFA.30802@gmx.de>
References: <cover.1452021349.git.moinejf@free.fr>
 <58463fd5b674c7eedec4ae05567ee56770a12996.1452021349.git.moinejf@free.fr>
 <568D7BFA.30802@gmx.de>
Message-ID: <20160113183730.9f0221a1cd48d9e094000da6@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 6 Jan 2016 21:41:30 +0100
Jens Kuske <jenskuske@gmx.de> wrote:

> On 05/01/16 19:40, Jean-Francois Moine wrote:
> [snip]
> > diff --git a/drivers/gpu/drm/sunxi/de2_hdmi_h3.c b/drivers/gpu/drm/sunxi/de2_hdmi_h3.c
> > new file mode 100644
> > index 0000000..c54b090
> > --- /dev/null
> > +++ b/drivers/gpu/drm/sunxi/de2_hdmi_h3.c
> > @@ -0,0 +1,478 @@
> > +/*
> > + * Allwinner H3 HDMI lowlevel functions
> > + *
> > + * Copyright (C) 2016 Jean-Francois Moine <moinejf@free.fr>
> > + *
> > + * Adapted from the file
> > + *	lichee/linux-3.4/drivers/video/sunxi/disp2/hdmi/aw/hdmi_bsp_sun8iw7.c
> > + * with no license nor copyright.
> > + */
	[snip]
> > +/*
> > + * [0] = vic (cea Video ID)
> > + * [1] used in hdmi_phy_set / bsp_hdmi_audio
> > + * [2..17] used in bsp_hdmi_video
> > + */
> > +static const struct para_tab ptbl[] = {
> > +	{{  6,  1, 1,  1,  5,  3, 0, 1, 4, 0, 0, 160,  20,  38, 124, 240, 22, 0, 0}},
	[snip]

> did you try to figure out what the values in this table actually mean?
> 
> I tried it some time ago because I wanted to add some more resolutions
> to 3.4, but never got further than what I'll add below. But it might be
> useful now, to get rid of at least some of the magic constants.
> With some more work (what does [1] mean?) we might be able to drop the
> entire table and use the values from drm_display_mode directly instead.
> 
> unsure (hard to verify):
> [2] = pixel repetition (1 = 2x)
> [3] = bit0: interlaced (no idea about the 96/0x60 yet)
> [17] = something csc related
> [18] = unused
> 
> pretty sure (verified by comparing with timings):
> [4] = horizontal active (high byte)
> [5] = vsync width
> [6] = vertical active (high byte)
> [7] = horizontal blanking (high byte)
> [8] = vertical front porch
> [9] = horizontal front porch (high byte)
> [10] = hsync width (high byte)
> [11] = horizontal active (low byte)
> [12] = horizontal blanking (low byte)
> [13] = horizontal front porch (low byte)
> [14] = hsync width (low byte)
> [15] = vertical active (low byte)
> [16] = vertical blanking
> 
> Generally, nice work. I only skimmed over it by now, but I hope to test
> and review the hardware related parts more intensively sometime.

Hi Jens,

Thanks for this information, but this table is only a very small part
of the HDMI code.

I doubt that anyone could understand the other sequences of the
functions of this BSP without documentation, or could do some reverse
engineering and understand how the DE2 HDMI device works.

So, I think that we have to wait for some information and/or
authorisation from Allwinner before putting a HDMI driver for the H3
(and A83T, A64...) into the mainline.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
