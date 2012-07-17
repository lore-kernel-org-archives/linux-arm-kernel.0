From: nico@fluxnic.net (Nicolas Pitre)
Date: Tue, 17 Jul 2012 17:18:28 -0400 (EDT)
Subject: Device tree.
In-Reply-To: <50057CD2.2060001@codethink.co.uk>
References: <500552C9.4090107@codethink.co.uk> <50056E22.5040308@gmail.com>
 <5b5e32ecde7b96d3af217054150eb43c@codethink.co.uk> <13863985.aH2icoQzEI@flexo>
 <50057CD2.2060001@codethink.co.uk>
Message-ID: <alpine.LFD.2.02.1207171712070.9293@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Jul 2012, Ian Molton wrote:

> On 17/07/12 15:02, Florian Fainelli wrote:
> > Depends on u-boot, the one we have been supplied doesn't seem to
> > have any interest in booting zImages.
> > In that case you just need to make sure that you produce a valid uImage of
> > your zImage+dtb appended. This is what I use on old (1.1.6) uboot versions
> > without any issues.
> 
> Thats what my little patch does. It just makes life a bit less painful if
> you're stuck with a particular bootloader. Its not an uncommon problem.

That pain is the only leverage we have to have you fix the bootloader 
somehow.  If you prefer or have to bodge around it then you keep the 
hack for yourself.

We want people to get into the habit of building and distributing a 
generic kernel image.  Appending a dtb to zImage and/or wrapping it into 
a uImage should be considered installation steps which are best done 
outside of the kernel build system.  And they are quite trivial to do as 
well.


Nicolas
