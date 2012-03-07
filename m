From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 07 Mar 2012 14:02:32 -0500 (EST)
Subject: [PATCH 2/3] Kbuild: Implement CONFIG_UIMAGE_KERNEL_NOLOAD
In-Reply-To: <20120307183633.GB27213@game.jcrosoft.org>
References: <1331080238-1524-1-git-send-email-swarren@wwwdotorg.org>
 <1331080238-1524-2-git-send-email-swarren@wwwdotorg.org>
 <20120307180815.GA27213@game.jcrosoft.org> <4F57AB92.6060907@wwwdotorg.org>
 <20120307183633.GB27213@game.jcrosoft.org>
Message-ID: <alpine.LFD.2.02.1203071354510.24151@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 7 Mar 2012, Jean-Christophe PLAGNIOL-VILLARD wrote:

> On 11:40 Wed 07 Mar     , Stephen Warren wrote:
> > On 03/07/2012 11:08 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > On 17:30 Tue 06 Mar     , Stephen Warren wrote:
> > >> This allows the user to use U-Boot's mkimage's -T kernel_noload option
> > >> if their arch Kconfig allows it, and they desire.
> > >>
> > >> Signed-off-by: Stephen Warren <swarren@wwwdotorg.org>
> > >> ---
> > >> The next patch enables this new CONFIG_ALLOW_ option for ARM. I assume
> > >> that some other architectures will also be able to enable it, but I'm
> > >> not familiar enough with any to know which.
> > > I'm going to repeat. I don't think any impromevent here.
> > > 
> > > with no specific kernel load address the uImage for is useless/
> > 
> > No, the whole point of this type of kernel image is that it doesn't need
> > a specific load address; the kernel zImage can run from anywhere in RAM
> > (provided AUTO_ZRELADDR is enabled, subject to some slight
> > restrictions), and hence the uImage doesn't need to be loaded to or
> > moved to any particular location.
> > 
> > The scripts that U-Boot runs determine where the image gets loaded into
> > memory.
> so instead of spending time on the uImage add simply the support the zImage to
> U-Boot as this AUTO_ZRELADDR have 0 advantage compare to the zImage

This was attempted in the past with the result that you might guess.

> > > And this no the job of the kernel to build a boot loader specific boot image
> > > format.
> > 
> > Not everyone agrees with this.
> so if a new boot loader apear or a new format the kernel will have to support
> it. No

Well, apparently new bootloaders are being corrupted by the u-Boot image 
format themselves.

And in the end I don't mind that much, as long as this is once again 
made architecture independent and therefore implemented in an 
architecture independent way in the kernel build system.

> > U-Boot does not currently have the ability to boot zImage on ARM.
> so add it and drop the uImage format

Why don't you try yourself?  I bet you already did in the past.

> > > Further more on server the vendor will use grub mostly (even on ARM) and will
> > > expect to boot a zImage.
> > 
> > But that is irrelevant for the people who are using U-Boot not grub.
> execpt the zIamge is the common boot format for all the server and PC and
> other boot loader

Look Jean-Christophe, we do have a kernel maintenance problem here.  
The goal of this patch series is to solve that maintenance problem while 
preserving the same level of support as before, not to change the world.


Nicolas
