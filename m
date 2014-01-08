From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 08 Jan 2014 20:07:41 +0100
Subject: [ANNOUNCE] sunxi-babelfish (FEX-to-DT translator)
In-Reply-To: <20140108185837.GI2941@lukather>
References: <20140107220310.GD3103@lukather>
 <201401081402.22036.arnd@arndb.de> <20140108185837.GI2941@lukather>
Message-ID: <11502088.u8KH7XkjeY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 08 January 2014 19:58:37 Maxime Ripard wrote:
> > I think it's a pretty cool idea. Have you considered integrating this with
> > the impedence-matcher project at
> > 
> > https://github.com/zonque/pxa-impedance-matcher ?
> > 
> > That one basically does the same thing for atags-based boot loaders and I
> > would guess that parts of the implementation can be shared as well, plus
> > the combination could support a wider range of devices.
> 
> Yep, I've considered it at first. Actually, I even took some bits out
> of it to use them.
> 
> But I thought this would be too far off the pxa-impedance-matcher to
> bother trying to fit it in. IIRC, pxa-impedance-matcher is taking the
> mach-id (mostly) to take an already existing DT and give it to the
> kernel, while we have pretty much the opposite where we have a generic
> mach-id, and build up the DTB from another source of information.

Yes, I understand the difference.

> I also integrated some fexc bits to be able to parse the script.bin
> file, which is highly sunxi specific.

I believe that the pxa-impedance-matcher now also contains some other
parts that go beyond just picking the right dtb file and interpreting
the atags, but I don't think any of them is as complex as the fex
parsing.

> But if Daniel's interested in merging all of this, I can totally
> consider it more seriously.

Let's see what he thinks then.

	Arnd
