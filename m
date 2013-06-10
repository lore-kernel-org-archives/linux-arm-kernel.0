From: dsd@laptop.org (Daniel Drake)
Date: Mon, 10 Jun 2013 09:36:51 -0600
Subject: Dove/Armada DRM driver naming
Message-ID: <CAMLZHHRFMmLsckBVDrxEGx9XaqhNq_sOFvDKq=Cx7HH938tkng@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I realise this is not overly important in the grand scheme of things,
but in case it is of interest:

At OLPC we work with Marvell MMP2 (a.k.a. Armada 610) and Marvell MMP3
(a.k.a. PXA2128).

Both have similar graphics hardware, they both are driven by
drivers/video/pxa168fb.c and xf86-video-dove
(http://dev.laptop.org/git/projects/xf86-video-dove/).

The same xf86-video-dove source is also used by the cubox project
(Dove), so I presume that cubox, MMP2 and MMP3 all have similar
graphics hardware that would be driven by this new DRM driver.

As the MMP3 does not fit under any form of "Armada" name, calling the
new DRM driver Armada may not be 100% accurate. Although, looking at
Documentation/arm/Marvell/README, finding a good name may not be
trivial.

The MMP2 and MMP3 include graphics silicon developed by Vivante. Would
it be more accurate to call this drm-vivante? I must admit I don't
have a complete understanding here: of is the whole graphics subsystem
driven by vivante silicon, or is the vivante part more of an isolated
add-on which can accelerate certain operations in graphics memory?

I look forward to trying this driver on MMP2/MMP3 soon - thanks for
your work here.

Daniel
