From: will.deacon@arm.com (Will Deacon)
Date: Tue, 1 Feb 2011 09:52:13 -0000
Subject: [PATCH] ARM: add Versatile Express defconfig
In-Reply-To: <AANLkTimzz5RAeuAWwss5krD_ogtN6u5ioQUS+e1ecyiB@mail.gmail.com>
References: <1296501243-28917-1-git-send-email-linus.walleij@linaro.org>	<3093351151219722808@unknownmsgid>
	<AANLkTimzz5RAeuAWwss5krD_ogtN6u5ioQUS+e1ecyiB@mail.gmail.com>
Message-ID: <002a01cbc1f5$b3ea0dc0$1bbe2940$@deacon@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hey Linus,

> > This will probably cause a compile-time error with a mainline kernel
> > because the necessary hotplug functions aren't implemented for vexpress.
> 
> Does compile for me on 2.6.38-rc1 (after I avoid an compiler ICE
> on the NOR flash driver by deselecting it, I don't blame the kernel
> for that one tho):

Is the ICE similar to this? :

drivers/mtd/maps/integrator-flash.c: In function 'armflash_probe':
drivers/mtd/maps/integrator-flash.c:262: internal compiler error: in remove_insn, at emit-rtl.c:3803
Please submit a full bug report,
with preprocessed source if appropriate.

If so, I reported that to the compiler guys in ARM and I think it
got fixed in the 2010q3 codesourcery toolchain (not sure where it
is upstream).
 
> Might this have something to do with it:
> 
> git log arch/arm/mach-vexpress/hotplug.c
> commit e9882777d992b76e0b80deadd66ad886c25f5d1f
> Author: Russell King <rmk+kernel@arm.linux.org.uk>
> Date:   Sun Dec 19 11:33:12 2010 +0000
> 
>     ARM: CPU hotplug: add Versatile Express hotplug CPU support
> 
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

Great, I missed that! Feel free to hotplug away in your defconfig.
 
> I don't know if it boots tho, if you pack up a Vexpress and
> mail it to my place I promise I will make more than just
> compiletests ;-)

I'd swap one for one of your boards with the funky PMU, but I think
some people might not be too happy about that.

Will
