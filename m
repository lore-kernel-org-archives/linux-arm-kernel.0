From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 24 Oct 2014 11:31:50 +0100
Subject: [PATCH 09/10] arm64/kexec: Enable kexec in the arm64 defconfig
In-Reply-To: <9570f274b9649430b34e5c7e15b63679b94c2c50.1414099246.git.geoff@infradead.org>
References: <cover.1414099246.git.geoff@infradead.org>
 <9570f274b9649430b34e5c7e15b63679b94c2c50.1414099246.git.geoff@infradead.org>
Message-ID: <20141024103150.GC24265@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 24, 2014 at 12:10:59AM +0100, Geoff Levand wrote:
> Signed-off-by: Geoff Levand <geoff@infradead.org>
> ---
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index d92ef3c..ebf8b3f 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -39,6 +39,7 @@ CONFIG_PREEMPT=y
>  CONFIG_KSM=y
>  CONFIG_TRANSPARENT_HUGEPAGE=y
>  CONFIG_CMA=y
> +CONFIG_KEXEC=y

Given this is going to be incompatible with KVM, and KVM is already in
defconfig, I don't think we can add this until that incompatibility is
fixed (or at the very least detected and handled gracefully).

Thanks,
Mark.

>  CONFIG_CMDLINE="console=ttyAMA0"
>  # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
>  CONFIG_COMPAT=y
> -- 
> 1.9.1
> 
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> 
