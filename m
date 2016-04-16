From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Sat, 16 Apr 2016 18:11:44 +0300
Subject: [PATCH 1/3] ACPI / ARM64: Don't enable ACPI by default on ARM64
In-Reply-To: <1460706823-16566-1-git-send-email-broonie@kernel.org>
References: <1460706823-16566-1-git-send-email-broonie@kernel.org>
Message-ID: <57125630.9080305@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 4/15/2016 10:53 AM, Mark Brown wrote:

> If ACPI is selectable it is enabled by default.  This is a good choice
> for architectures where the overwhelming majority of systems use ACPI
> like x86 and IA-64 but is less clear for architectures where it's less
> common like ARM64.  Change the default selection so that it's only done
> explicitly on those architectures where ACPI is universally used.
>
> Signed-off-by: Mark Brown <broonie@kernel.org>
> ---
>   drivers/acpi/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
> index 82b96ee8624c..2fcf87a6d270 100644
> --- a/drivers/acpi/Kconfig
> +++ b/drivers/acpi/Kconfig
> @@ -8,7 +8,7 @@ menuconfig ACPI
>   	depends on IA64 || X86 || (ARM64 && EXPERT)
>   	depends on PCI
>   	select PNP
> -	default y
> +	default y if (IA64 || X86)

    Parens not needed.

[...]

MBR, Sergei
