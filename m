From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Nov 2015 11:15:52 +0000
Subject: [PATCH v3 44/62] ACPICA: ACPI 6.0: Add support for STAO table
In-Reply-To: <1447753261-7552-45-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-45-git-send-email-shannon.zhao@linaro.org>
Message-ID: <alpine.DEB.2.02.1511271115450.8984@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 17 Nov 2015, shannon.zhao at linaro.org wrote:
> From: Bob Moore <robert.moore@intel.com>
> 
> ACPICA commit 532bf402a503061afd9d80a23e1d3c8fd99b052c
> 
> _STA override table.
> 
> Link: https://github.com/acpica/acpica/commit/532bf402
> Signed-off-by: Bob Moore <robert.moore@intel.com>
> Signed-off-by: Lv Zheng <lv.zheng@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> [Linux commit 37e12657f8922ebc62f696494c56c81db509053e]
> Signed-off-by: Shannon Zhao <shannon.zhao@linaro.org>

Acked-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>


>  xen/include/acpi/actbl3.h | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/xen/include/acpi/actbl3.h b/xen/include/acpi/actbl3.h
> index fc96963..cb9e1c0 100644
> --- a/xen/include/acpi/actbl3.h
> +++ b/xen/include/acpi/actbl3.h
> @@ -68,6 +68,7 @@
>  #define ACPI_SIG_PCCT           "PCCT"	/* Platform Communications Channel Table */
>  #define ACPI_SIG_PMTT           "PMTT"	/* Platform Memory Topology Table */
>  #define ACPI_SIG_RASF           "RASF"	/* RAS Feature table */
> +#define ACPI_SIG_STAO           "STAO" /* Status Override table */
>  
>  #define ACPI_SIG_S3PT           "S3PT"	/* S3 Performance (sub)Table */
>  #define ACPI_SIG_PCCS           "PCC"	/* PCC Shared Memory Region */
> @@ -618,6 +619,21 @@ enum acpi_rasf_status {
>  #define ACPI_RASF_ERROR                 (1<<2)
>  #define ACPI_RASF_STATUS                (0x1F<<3)
>  
> +/*******************************************************************************
> + *
> + * STAO - Status Override Table (_STA override) - ACPI 6.0
> + *        Version 1
> + *
> + * Conforms to "ACPI Specification for Status Override Table"
> + * 6 January 2015
> + *
> + ******************************************************************************/
> +
> +struct acpi_table_stao {
> +	struct acpi_table_header header;	/* Common ACPI table header */
> +	u8 ignore_uart;
> +};
> +
>  /* Reset to default packing */
>  
>  #pragma pack()
> -- 
> 2.1.0
> 
