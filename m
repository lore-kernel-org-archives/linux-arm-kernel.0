From: takahiro.akashi@linaro.org (AKASHI Takahiro)
Date: Mon, 9 Jul 2018 15:31:56 +0900
Subject: [PATCH v10 07/14] arm64: enable KEXEC_FILE config
In-Reply-To: <9545cb7f-9648-660a-f034-a94f186a8224@arm.com>
References: <20180623022058.10935-1-takahiro.akashi@linaro.org>
 <20180623022058.10935-8-takahiro.akashi@linaro.org>
 <9545cb7f-9648-660a-f034-a94f186a8224@arm.com>
Message-ID: <20180709063136.GS28220@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

James,

On Tue, Jul 03, 2018 at 05:33:20PM +0100, James Morse wrote:
> Hi Akashi,
> 
> On 23/06/18 03:20, AKASHI Takahiro wrote:
> > Modify arm64/Kconfig to enable kexec_file_load support.
> 
> > diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> > index 42c090cf0292..f68318f61c85 100644
> > --- a/arch/arm64/Kconfig
> > +++ b/arch/arm64/Kconfig
> > @@ -835,6 +835,16 @@ config KEXEC
> >  	  but it is independent of the system firmware.   And like a reboot
> >  	  you can start any kernel with it, not just Linux.
> >  
> > +config KEXEC_FILE
> > +	bool "kexec file based system call"
> > +	select KEXEC_CORE
> > +	select BUILD_BIN2C
> 
> Wasn't BIN2C only needed for purgatory?

Right. Will remove it.

> x86/powerpc/s390 all select CRYPTO_SHA256 here, presumably for arch-specific
> verification mechanisms. I assume we're using SIGNED_PE_FILE_VERIFICATION instead.

To be clear, hash check (sha256) will be done at reboot (in purgatory),
while binary verification will be done at load.

> 
> > +	help
> > +	  This is new version of kexec system call. This system call is
> > +	  file based and takes file descriptors as system call argument
> > +	  for kernel and initramfs as opposed to list of segments as
> > +	  accepted by previous system call.
> > +
> >  config CRASH_DUMP
> >  	bool "Build kdump crash kernel"
> >  	help
> 
> 
> Acked-by: James Morse <james.morse@arm.com>

Thanks!
-Takahiro AKASHI

> 
> Thanks,
> 
> James
