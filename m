From: balbi@ti.com (Felipe Balbi)
Date: Fri, 7 Jan 2011 14:57:19 +0200
Subject: Build breakage with omap2plus_defconfig
In-Reply-To: <d36c47cf71accc194040e98d74f768c0@mail.gmail.com>
References: <20110107123859.GA9592@legolas.emea.dhcp.ti.com>
	<d36c47cf71accc194040e98d74f768c0@mail.gmail.com>
Message-ID: <20110107125719.GC9592@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 07, 2011 at 06:20:43PM +0530, Anand Gadiyar wrote:
> Felipe Balbi wrote:
> > Hi all,
> >
> > Today's Linus' tree
> > (01539ba2a706ab7d35fc0667dff919ade7f87d63) fails to
> > build with omap2plus_defconfig:
> >
> > $ crossmake
> >   CHK     include/linux/version.h
> >   CHK     include/generated/utsrelease.h
> > make[1]: `include/generated/mach-types.h' is up to date.
> >   CALL    scripts/checksyscalls.sh
> >   CHK     include/generated/compile.h
> >   CC      arch/arm/kernel/swp_emulate.o
> > /tmp/cc2V7p5j.s: Assembler messages:
> > /tmp/cc2V7p5j.s:161: Error: selected processor does not support ARM mode
> `ldrexb r3,[r4]'
> > /tmp/cc2V7p5j.s:162: Error: selected processor does not support ARM mode
> `strexb r0,r2,[r4]'
> > make[1]: *** [arch/arm/kernel/swp_emulate.o] Error 1
> > make: *** [arch/arm/kernel] Error 2
> 
> I haven't found a way around this other than to turn off
> CONFIG_SWP_EMULATE. Here's a patch doing that [1].
> 
> The discussion thread is here [2].

Thanks a lot Anand :-)

-- 
balbi
