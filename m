From: florian@openwrt.org (Florian Fainelli)
Date: Tue, 17 Jul 2012 14:41:35 +0200
Subject: Device tree.
In-Reply-To: <20120717142926.05c0c17f@skate>
References: <500552C9.4090107@codethink.co.uk>
 <500556CF.6030704@codethink.co.uk> <20120717142926.05c0c17f@skate>
Message-ID: <4030979.D58EjbuuB0@flexo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 17 July 2012 14:29:26 Thomas Petazzoni wrote:
> Le Tue, 17 Jul 2012 13:13:03 +0100,
> Ian Molton <ian.molton@codethink.co.uk> a ?crit :
> 
> > Unless I'm misunderstanding it, thats not quite what I need -
> > although I should probably have made my hack depend on it.
> > 
> > I'm using a uImage; The prepending needs to happen to the zImage /
> > Image.
> 
> What I typically do is generate a zImage, do the appending, and then
> generate the uImage manually with mkimage. But I agree it could be
> useful to have a 'make uImage.myboard' target which would happen the
> myboard.dtb before preparing the uImage.

Appending a given device tree blob to a zImage is something that should be 
solved outside of the kernel build imho.

Since your bootloader is already "non-cooperative" wrt DTBs, you need to 
provide a specific uImage (zImage + dtb) for it.

I do not think the kernel build should try to generate as many zImages as 
there dtb files, nor any other combination, this really is distribution 
specific.
--
Florian
