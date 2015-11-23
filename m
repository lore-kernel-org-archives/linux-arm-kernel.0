From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 23 Nov 2015 14:52:10 +0000
Subject: [PATCH v3 16/62] ACPICA: ACPI 6.0: Add values for MADT GIC
 version field
In-Reply-To: <1447753261-7552-17-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-17-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511231452020.1107@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> ACPICA commit 4b100dc43e8baee8c8b4891b23bc7ad03eba6a28
> 
> Support for the new version field in the generic distributor
> subtable. Hanjun Guo <hanjun.guo@linaro.org>
> 
> Link: https://github.com/acpica/acpica/commit/4b100dc4
> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [Linux commit a8bd0f07eb594df51845d33f272fb1952fec1a6f]
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/include/acpi/actbl1.h | 11 +++++++++++
>  1 file changed, 11 insertions(+)
> 
> diff --git a/xen/include/acpi/actbl1.h b/xen/include/acpi/actbl1.h
> index 7dd6960..cf31837 100644
> --- a/xen/include/acpi/actbl1.h
> +++ b/xen/include/acpi/actbl1.h
> @@ -804,6 +804,17 @@ struct acpi_madt_generic_distributor {
>  	u8 reserved2[3];          /* reserved - must be zero */
>  };
>  
> +/* Values for Version field above */
> +
> +enum acpi_madt_gic_version {
> +	ACPI_MADT_GIC_VERSION_NONE = 0,
> +	ACPI_MADT_GIC_VERSION_V1 = 1,
> +	ACPI_MADT_GIC_VERSION_V2 = 2,
> +	ACPI_MADT_GIC_VERSION_V3 = 3,
> +	ACPI_MADT_GIC_VERSION_V4 = 4,
> +	ACPI_MADT_GIC_VERSION_RESERVED = 5      /* 5 and greater are reserved */
> +};
> +
>  /* 13: GIC MSI Frame (ACPI 5.1) */
>  
>  struct acpi_madt_generic_msi_frame {
> -- 
> 2.1.0
> 
