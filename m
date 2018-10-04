From: dinguyen@kernel.org (Dinh Nguyen)
Date: Thu, 4 Oct 2018 03:21:44 -0500
Subject: SoCFPGA Turn on ARM errata for L2 cache ?
In-Reply-To: <CAJiuCcdR5dfN3MtvoqOMEG1hK+EuYgsdAaabW5wQrEDTdAOQdw@mail.gmail.com>
References: <CAJiuCcdR5dfN3MtvoqOMEG1hK+EuYgsdAaabW5wQrEDTdAOQdw@mail.gmail.com>
Message-ID: <c6ad1229-72b1-a7ab-554b-429debc5ee30@kernel.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 10/03/2018 11:03 AM, Cl?ment P?ron wrote:
> Hi,
> 
> Saw this patch on the Altera OpenSource GitHub.
> 
> But it's not mainlained can I propose it?
>

You sure can!

> How do you do when the patch is from someone else ? Do you keep the
> sign-off of the original author or do you just mention it? in the
> commit log ?

Sure, just keep the original Signed-off-by:.

Thanks,
Dinh

> 
> Thanks,
> Clement
> 
> From 6f7559407c1fcdb9b31c9493f0da79d614290e91 Mon Sep 17 00:00:00 2001
> From: Dinh Nguyen <dinguyen@kernel.org>
> Date: Wed, 27 Feb 2013 18:29:14 -0600
> Subject: [PATCH] ARM: socfpga: Turn on ARM errata for L2 cache
> 
> Turn on these ARM and PL310 errata for SoCFPGA:
> 
> ARM_ERRATA_754322
> ARM_ERRATA_764369
> ARM_ERRATA_775420
> 
> PL310_ERRATA_588369
> PL310_ERRATA_727915
> PL310_ERRATA_753970
> PL310_ERRATA_769419
> 
> Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
> ---
>  arch/arm/mach-socfpga/Kconfig | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/arm/mach-socfpga/Kconfig b/arch/arm/mach-socfpga/Kconfig
> index 4adb901dd5eb..a04660918d71 100644
> --- a/arch/arm/mach-socfpga/Kconfig
> +++ b/arch/arm/mach-socfpga/Kconfig
> @@ -11,6 +11,13 @@ menuconfig ARCH_SOCFPGA
>   select HAVE_ARM_TWD if SMP
>   select MFD_SYSCON
>   select PCI_DOMAINS if PCI
> + select ARM_ERRATA_754322
> + select ARM_ERRATA_764369 if SMP
> + select ARM_ERRATA_775420
> + select PL310_ERRATA_588369
> + select PL310_ERRATA_727915
> + select PL310_ERRATA_753970 if PL310
> + select PL310_ERRATA_769419
> 
>  if ARCH_SOCFPGA
>  config SOCFPGA_SUSPEND
> 
