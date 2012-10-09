From: richardcochran@gmail.com (Richard Cochran)
Date: Tue, 9 Oct 2012 13:43:26 +0200
Subject: Booting vanilla kernel on the beaglebone
In-Reply-To: <79CD15C6BA57404B839C016229A409A83EB39D66@DBDE01.ent.ti.com>
References: <20120930082802.GA15392@netboy.at.omicron.at>
 <50693ECD.4000000@ti.com>
 <20121008191657.GA3281@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39685@DBDE01.ent.ti.com>
 <20121009110049.GB2274@netboy.at.omicron.at>
 <79CD15C6BA57404B839C016229A409A83EB39D66@DBDE01.ent.ti.com>
Message-ID: <20121009114326.GA4511@netboy.at.omicron.at>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 09, 2012 at 11:19:28AM +0000, Hiremath, Vaibhav wrote:
> On Tue, Oct 09, 2012 at 16:30:50, Richard Cochran wrote:
> > On Tue, Oct 09, 2012 at 05:57:22AM +0000, Hiremath, Vaibhav wrote:
> > > 
> > > I use omap2plus_defconfig + CONFIG_ARM_APPENDED_DTB + CONFIG_ARM_ATAG_DTB_COMPAT and nothing more.
> >                                          ^
> > -----------------------------------------+  ???
> > 
> > But in the u-boot console example you post, you load the dtb into
> > memory.
> > 
> 
> Its standard mechanism to boot kernel with DT and it is nothing to do 
> with .config. as mentioned before I have already submitted patch to add dtb 
> target to 'make dtbs'.

You say that you use CONFIG_ARM_APPENDED_DTB, which means:

   CONFIG_ARM_APPENDED_DTB:
   
   With this option, the boot code will look for a device tree binary
   (DTB) appended to zImage
   (e.g. cat zImage <filename>.dtb > zImage_w_dtb).
   
   This is meant as a backward compatibility convenience for those
   systems with a bootloader that can't be upgraded to accommodate
   the documented boot protocol using a device tree. 

But in the example you gave, you seem to load the dtb in the "normal"
way, with a dtb-aware u-boot.

So how do you boot this? With the APPENDED hack? Or just using a
recent u-boot?

Thanks,
Richard
