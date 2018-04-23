From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Mon, 23 Apr 2018 14:49:40 +0200
Subject: [PATCH] arm64: dts: marvell: armada-37xx: reserve memory for ATF
In-Reply-To: <20180423103127.5b9ac041@xps13>
References: <20180421140342.25082-1-miquel.raynal@bootlin.com>
 <20180421161859.22d1ed18@windsurf> <20180423103127.5b9ac041@xps13>
Message-ID: <20180423144940.64fa884d@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 23 Apr 2018 10:31:27 +0200, Miquel Raynal wrote:

> > Shouldn't this be done automatically by the bootloader, before passing
> > the DTB to the kernel ?  
> 
> I am working with a 2017.09 mainline U-Boot.
> 
> I did not know the bootloader was supposedly in charge of that.

I thought it should be the case, but I indeed see nothing in U-Boot
that does that, except for OMAP2 platforms.

> But what if it fails doing it?

Well if something fails in the boot process, the platform fails to boot.
I find this question a bit weird/silly. It's like "and what if the user
used the wrong DT for the wrong platform ?"

> Fixing the bootloader is one thing, I assume very few people would
> update it. Is it worth keeping this in Linux DT?

The issue I see with having this in the Linux DT is that depending on
the bootloader, the memory area that is used to keep the PSCI firmware
may very well be different. It's really not a property of the HW
itself, but a pure software choice of the bootloader. For example, are
you sure the mainline U-Boot puts the PSCI firmware at the same place
as the vendor U-Boot ?

What are other platforms doing to solve this problem ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
