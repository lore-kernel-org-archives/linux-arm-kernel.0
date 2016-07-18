From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 18 Jul 2016 14:49:52 +0200
Subject: running "make dtbs" for test builds
In-Reply-To: <20160718122947.GA29820@wfg-t540p.sh.intel.com>
References: <8924490.SntxSU2FOC@wuerfel>
 <20160718122947.GA29820@wfg-t540p.sh.intel.com>
Message-ID: <1887216.FoLArqn3oq@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, July 18, 2016 8:29:47 PM CEST Fengguang Wu wrote:
> >- setting CONFIG_OF_ALL_DTBS will catch all files, not just the
> >  ones that are built by default for the set of configurations you
> >  have. It's possible to simply override this on the command line,
> >  using "make CONFIG_OF_ALL_DTBS=y", it doesn't actually have to
> >  be part of the configuration. The result is independent of the
> >  actual configuration, so it should be enough to do this once
> >  per architecture and source revision.
> >
> >Is this something you can add?
> 
> Do you mean to simply change the main "make" command line to
> 
>         make ARCH=xxx CONFIG_OF_ALL_DTBS=y
> 
> Which looks safe even for ARCHs that do not support it.
> 
> The arch/.../Makefile that actually use it are:
> 
>         arch/arc/boot/dts/Makefile
>         arch/arm/boot/dts/Makefile
>         arch/arm64/boot/dts/Makefile
>         arch/h8300/boot/dts/Makefile
>         arch/metag/boot/dts/Makefile
>         arch/mips/boot/dts/Makefile
>         arch/xtensa/boot/dts/Makefile
> 

Sounds good, thanks!

	Arnd
