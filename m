From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Mon, 23 Apr 2018 17:15:59 +0200
Subject: [PATCH] arm64: dts: marvell: armada-37xx: reserve memory for ATF
In-Reply-To: <20180423144940.64fa884d@windsurf>
References: <20180421140342.25082-1-miquel.raynal@bootlin.com>
 <20180421161859.22d1ed18@windsurf> <20180423103127.5b9ac041@xps13>
 <20180423144940.64fa884d@windsurf>
Message-ID: <20180423171559.53bcc2d9@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas,

On Mon, 23 Apr 2018 14:49:40 +0200, Thomas Petazzoni
<thomas.petazzoni@bootlin.com> wrote:

> Hello,
> 
> On Mon, 23 Apr 2018 10:31:27 +0200, Miquel Raynal wrote:
> 
> > > Shouldn't this be done automatically by the bootloader, before passing
> > > the DTB to the kernel ?    
> > 
> > I am working with a 2017.09 mainline U-Boot.
> > 
> > I did not know the bootloader was supposedly in charge of that.  
> 
> I thought it should be the case, but I indeed see nothing in U-Boot
> that does that, except for OMAP2 platforms.
> 
> > But what if it fails doing it?  
> 
> Well if something fails in the boot process, the platform fails to boot.
> I find this question a bit weird/silly. It's like "and what if the user
> used the wrong DT for the wrong platform ?"

Sorry, I meant "what if the bootloader does not do it?", in other
words: currently the bootloader does not do it, let's assume it should,
shall we take into account that it does not and add this code to Linux
too, or shall we say to people "upgrade your bootloader/ATF"? But from
the rest of your answer I assume the latter is the right approach.

> 
> > Fixing the bootloader is one thing, I assume very few people would
> > update it. Is it worth keeping this in Linux DT?  
> 
> The issue I see with having this in the Linux DT is that depending on
> the bootloader, the memory area that is used to keep the PSCI firmware
> may very well be different. It's really not a property of the HW
> itself, but a pure software choice of the bootloader. For example, are
> you sure the mainline U-Boot puts the PSCI firmware at the same place
> as the vendor U-Boot ?
> 
> What are other platforms doing to solve this problem ?

I will also check if it is actually U-Boot or ATF choice. My
understanding is that ATF's handle the PSCI firmware but U-Boot should
propagate a reserved node (for this firmware) in Linux's DTB. Let me
check all of that.

> 
> Best regards,
> 
> Thomas


Thanks,
Miqu?l

-- 
Miquel Raynal, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
