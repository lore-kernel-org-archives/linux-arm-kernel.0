From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 24 Oct 2010 23:08:46 +0100
Subject: cmpxchg() in recent kernels
In-Reply-To: <20101024214338.GB878@boggieman.bredbandsbolaget.se>
References: <4CB036B7.7000100@gai.ru>
	<AANLkTi=PeHQRibtU=jv69KVNWovtNsG3S11M0BLCnbRC@mail.gmail.com>
	<20101024214338.GB878@boggieman.bredbandsbolaget.se>
Message-ID: <20101024220846.GA6041@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 24, 2010 at 11:43:38PM +0200, Kristoffer Ericson wrote:
> Im seeing something similiar, using GCC 3.4.5
> ARM HP Jornada 720, 2.6.36
> 
>   GZIP    kernel/config_data.gz
>   IKCFG   kernel/config_data.h
>   CC      kernel/configs.o
>   LD      kernel/built-in.o
>   LD      drivers/pcmcia/built-in.o
>   LD      drivers/built-in.o
>   LD      vmlinux.o
>   MODPOST vmlinux.o
> WARNING: modpost: Found 1 section mismatch(es).
> To see full details build your kernel with:
> 'make CONFIG_DEBUG_SECTION_MISMATCH=y'
>   GEN     .version
>   CHK     include/generated/compile.h
>   UPD     include/generated/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> kernel/built-in.o(.text+0x1d038): In function `alloc_pid':
> include/asm-generic/cmpxchg-local.h:42: undefined reference to `wrong_size_cmpxchg'
> make: *** [.tmp_vmlinux1] Error 1

Probably needs to be bisected, but I think in the long run we'll have
to accept that gcc 4 will become the minimum compiler version.
