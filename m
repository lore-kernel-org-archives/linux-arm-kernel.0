From: hanjun.guo@linaro.org (Hanjun Guo)
Date: Fri, 19 Jun 2015 18:49:11 +0800
Subject: [PATCH v2 1/3] ACPI : introduce macros for using the ACPI
 specification version
In-Reply-To: <1434666968-1543-2-git-send-email-al.stone@linaro.org>
References: <1434666968-1543-1-git-send-email-al.stone@linaro.org>
 <1434666968-1543-2-git-send-email-al.stone@linaro.org>
Message-ID: <5583F3A7.4020202@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/19/2015 06:36 AM, Al Stone wrote:
> Add the ACPI_SPEC_VERSION() macro to build a proper version number from
> a major and minor revision number.  Add also the ACPI_FADT_SPEC_VERSION
> that constructs a proper version number from the entries in the current
> FADT.
>
> These macros are added in order to simplify retrieving and comparing ACPI
> specification version numbers, since this is becoming a more frequent need.
> In particular, there are some architectures that require at least a certain
> version of the spec, and there are differences in some structure sizes that
> have changed with recent versions but can only be tracked by spec version
> number.
>
> Signed-off-by: Al Stone <al.stone@linaro.org>
> ---
>   include/linux/acpi.h | 5 +++++
>   1 file changed, 5 insertions(+)
>
> diff --git a/include/linux/acpi.h b/include/linux/acpi.h
> index a4acb55..33ed313 100644
> --- a/include/linux/acpi.h
> +++ b/include/linux/acpi.h
> @@ -48,6 +48,11 @@
>   #include <acpi/acpi_io.h>
>   #include <asm/acpi.h>
>
> +#define ACPI_SPEC_VERSION(major, minor)	((major<<8)|minor)

and minor comments for code style

((major<<8)|minor) - > ((major << 8) | minor)

other than that:

Reviewed-by: Hanjun Guo <hanjun.guo@linaro.org>

Thanks
Hanjun

> +#define ACPI_FADT_SPEC_VERSION	\
> +	ACPI_SPEC_VERSION(acpi_gbl_FADT.header.revision, \
> +			  acpi_gbl_FADT.minor_revision)
> +
>   static inline acpi_handle acpi_device_handle(struct acpi_device *adev)
>   {
>   	return adev ? adev->handle : NULL;
>
