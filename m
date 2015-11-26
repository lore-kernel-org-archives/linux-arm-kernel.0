From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Thu, 26 Nov 2015 12:18:55 -0500 (EST)
Subject: ARCH_MULTIPLATFORM + ARM_APPENDED_DTB + custom boot-loader
In-Reply-To: <56573CEE.10101@free.fr>
References: <565738F7.1060204@free.fr> <56573CEE.10101@free.fr>
Message-ID: <alpine.LFD.2.20.1511261211150.22569@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 26 Nov 2015, Mason wrote:

> On 26/11/2015 17:53, Mason wrote:
> 
> > I'm using an ARCH_MULTIPLATFORM kernel with an appended DTB.
> > I make a uImage out of this zImage+DTB.
> > On my board, U-Boot passes control to Linux, which boots correctly.
> > 
> > But when I replace U-Boot with a custom boot-loader, Linux tries
> > to boot some kind of "Generic DT based system" rather than the DT
> > I appended.

If you have a custom bootloader, why are you using an appended DTB?

The appended DTB feature should be a last resort solution only when 
there  is no way to make the bootloader behave correctly.

> The custom boot-loader was given an Image (not a uImage) and the DT
> was probably not appended to the Image.
> 
> Question: can a DT be appended to an Image, or does it have to be
> appended to a zImage? 

It works with zImage only.

> Can a zImage be uncompressed or compressed with a null compressor?


Please consider fixing your bootloader to provide a DT to the kernel the 
official way.  Then you'll have the freedom to use a uImage, zImage or 
Image as you see fit without contraptions such as a null compressor.


Nicolas
