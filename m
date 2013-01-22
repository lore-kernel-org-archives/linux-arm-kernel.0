From: mpfj-list@mimc.co.uk (Mark Jackson)
Date: Tue, 22 Jan 2013 13:39:30 +0000
Subject: OMAP baseline test results for v3.8-rc4
In-Reply-To: <B5906170F1614E41A8A28DE3B8D121433ECF3DD3@DBDE01.ent.ti.com>
References: <alpine.DEB.2.00.1301202136290.31667@utopia.booyaka.com>
 <50FD6D8D.6030106@mimc.co.uk> <20130121164510.GA18905@kahuna>
 <f36acfaf128c4844b8f696ea4440e253@DLEE74.ent.ti.com>
 <20130121182419.GE10020@beef> <87boci9str.fsf@dell.be.48ers.dk>
 <alpine.DEB.2.00.1301220213390.25789@utopia.booyaka.com>
 <50FE66AC.2090306@mimc.co.uk>
 <B5906170F1614E41A8A28DE3B8D121433ECF3DD3@DBDE01.ent.ti.com>
Message-ID: <50FE9692.2090001@mimc.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/01/13 13:32, Bedia, Vaibhav wrote:

<snip>

> Following works for me:
> 
> Kernel
> ===
> git checkout next-20130122
> make distclean
> make omap2plus_defconfig
> <Enable the appended DTB related options via menuconfig>
> make -j7
> cat arch/arm/boot/zImage arch/arm/boot/dts/am335x-bone.dtb > arch/arm/boot/zImage-dtb.am335x-bone
> mkimage -A arm -O linux -C none -T kernel -a 0x80008000 -e 0x80008000 -n 'Linux' -d arch/arm/boot/zImage-dtb.am335x-bone arch/arm/boot/uImage-dtb.am335x-bone
> 
> U-Boot
> ===
> Built from v2013.01

<snip>

> A dumb question... in your case what's the bootargs set? Note that the mainline
> kernel for AM335x doesn't have MMC support yet and the default bootargs is set to
> rootfs on MMC.

Yes ... I'm trying to boot from a rootfs on MMC:-

Kernel command line: console=ttyO0,115200n8 earlyprintk debug root=/dev/mmcblk0p2 ro rootfstype=ext2
rootwait

But I should get *something* from the kernel before it starts trying to access the rootfs ?

Regards
Mark J.
