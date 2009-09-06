From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Sun, 6 Sep 2009 20:15:17 +0200 (CEST)
Subject: [PATCH] Add RGB555X and RGB565X formats to pxa-camera
In-Reply-To: <200909061951.44629.marek.vasut@gmail.com>
References: <200908031031.00676.marek.vasut@gmail.com>
	<200909060550.23681.marek.vasut@gmail.com>
	<Pine.LNX.4.64.0909061755020.10484@axis700.grange>
	<200909061951.44629.marek.vasut@gmail.com>
Message-ID: <Pine.LNX.4.64.0909062004160.10484@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 6 Sep 2009, Marek Vasut wrote:

> Dne Ne 6. z??? 2009 18:52:55 Guennadi Liakhovetski napsal(a):
> > On Sun, 6 Sep 2009, Marek Vasut wrote:
> > > Ah damn, I see what you mean. What the camera does is it swaps the RED
> > > and BLUE channel:
> > > 15  14  13  12  11  10  09  08  07  06  05  04  03  02  01  00
> > > B4  B3  B2  B1  B0  G4  G3  G2  G1  G1  R4  R3  R2  R1  R1  --
> > > so it's more a BGR555/565 then. I had to patch fswebcam for this.
> >
> > Ok, this is, of course, something different. In this case you, probably,
> > could deceive the PXA to handle blue as red and the other way round, but
> > still, I would prefer not to do that. Hence my suggestion remains - pass
> > these formats as raw data.
> >
> Which is bogus from the camera point of view.

Not at all. This just means: the subdevice provides a pixel format, that 
the bridge (PXA) knows nothing specific about, but it can just pass it 
one-to-one (as raw data) to the user - don't see anything bogus in this. 
Different bridges have support for different pixel colour formats, but, I 
think, all bridges can pass data as raw (pass-through). Some bridges can 
_only_ do this, so, this is actually the default video-capture mode.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
