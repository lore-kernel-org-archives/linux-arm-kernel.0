From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 31 Mar 2016 11:44:29 +0800
Subject: [PATCH] ACPI / ARM64: Remove EXPERT dependency for ACPI on ARM64
In-Reply-To: <1459360718-24125-1-git-send-email-broonie@kernel.org>
References: <1459360718-24125-1-git-send-email-broonie@kernel.org>
Message-ID: <56FC9D1D.6090808@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2016/3/31 1:58, Mark Brown wrote:
> When ACPI was originally merged for arm64 it had only been tested on
> emulators and not on real physical platforms and no platforms were
> relying on it.  This meant that there were concerns that there might be
> serious issues attempting to use it on practical systems so it had a
> dependency on EXPERT added to warn people that it was in an early stage
> of development with very little practical testing.  Since then things
> have moved on a bit.  We have seen people testing on real hardware and
> now have people starting to produce some platforms (the most prominent
> being the 96boards Cello) which only have ACPI support and which build
> and run to some useful extent with mainline.
>
> This is not to say that ACPI support or support for these systems is
> completely done, there are still areas being worked on such as PCI, but
> at this point it seems that we can be reasonably sure that ACPI will be
> viable for use on ARM64 and that the already merged support works for
> the cases it handles.  For the AMD Seattle based platforms support
> outside of PCI has been fairly complete in mainline a few releases now.
>
> This is also not to say that we don't have vendors working with ACPI who
> are trying do things that we would not consider optimal but it does not
> appear that the EXPERT dependency is having a substantial impact on
> these vendors.
>
> Given all this it seems that at this point the EXPERT dependency mainly
> creates inconvenience for users with systems that are doing the right
> thing and gets in the way of including the ACPI code in the testing that
> people are doing on mainline.  Removing it should help our ongoing
> testing cover those platforms with only ACPI support and help ensure
> that when ACPI code is merged any problems it causes for other users are
> more easily discovered.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Acked-by: Hanjun Guo <hanjun.guo@linaro.org>

> ---
>  drivers/acpi/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee8624c..bf5dc1ac3446 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -5,7 +5,7 @@
>  menuconfig ACPI
>  	bool "ACPI (Advanced Configuration and Power Interface) Support"
>  	depends on !IA64_HP_SIM
> -	depends on IA64 || X86 || (ARM64 && EXPERT)
> +	depends on IA64 || X86 || ARM64
>  	depends on PCI
>  	select PNP
>  	default y
