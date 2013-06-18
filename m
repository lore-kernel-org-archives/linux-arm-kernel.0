From: will.deacon@arm.com (Will Deacon)
Date: Tue, 18 Jun 2013 14:52:50 +0100
Subject: [PATCH] arm64/Makefile: provide vdso_install target
In-Reply-To: <20130616193243.GC8939@redacted.bos.redhat.com>
References: <20130616193243.GC8939@redacted.bos.redhat.com>
Message-ID: <20130618135250.GH6801@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 16, 2013 at 08:32:44PM +0100, Kyle McMartin wrote:
> Provide a vdso_install target in the arm64 Makefile, as other architectures
> with a vdso do.

Thanks Kyle.

  Acked-by: Will Deacon <will.deacon@arm.com>

Will

> Signed-off-by: Kyle McMartin <kyle@redhat.com>
> 
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -60,6 +60,10 @@ zinstall install: vmlinux
>  dtbs: scripts
>  	$(Q)$(MAKE) $(build)=$(boot)/dts dtbs
>  
> +PHONY += vdso_install
> +vdso_install:
> +	$(Q)$(MAKE) $(build)=arch/arm64/kernel/vdso $@
> +
>  # We use MRPROPER_FILES and CLEAN_FILES now
>  archclean:
>  	$(Q)$(MAKE) $(clean)=$(boot)
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
