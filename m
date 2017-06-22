From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 22 Jun 2017 14:43:03 +0100
Subject: [PATCH v4 1/2] ACPICA: ACPI 6.2: Add support for new SRAT subtable
In-Reply-To: <1498111812-17053-2-git-send-email-ganapatrao.kulkarni@cavium.com>
References: <1498111812-17053-1-git-send-email-ganapatrao.kulkarni@cavium.com>
 <1498111812-17053-2-git-send-email-ganapatrao.kulkarni@cavium.com>
Message-ID: <20170622134303.GA9732@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rafael, Lv, Robert,

On Thu, Jun 22, 2017 at 11:40:11AM +0530, Ganapatrao Kulkarni wrote:
> Add GIC ITS Affinity (ACPI 6.2) subtable to SRAT table.
> 
> ACPICA commit 5bc67f63918da249bfe279ee461d152bb3e6f55b
> Link: https://github.com/acpica/acpica/commit/5bc67f6
> 
> Signed-off-by: Ganapatrao Kulkarni <ganapatrao.kulkarni@cavium.com>
> ---
>  include/acpi/actbl1.h | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)

This patch is fine to me but it is up to you or who sends the ACPICA
pull request to send it upstream or give us an ACK so that it can go
via irqchip.

We need to know how this commit (and other ACPICA changes) will be sent
upstream to handle trees dependencies, please advise it is a bit urgent,
thank you.

Lorenzo

> diff --git a/include/acpi/actbl1.h b/include/acpi/actbl1.h
> index b4ce55c..253c9db 100644
> --- a/include/acpi/actbl1.h
> +++ b/include/acpi/actbl1.h
> @@ -1192,7 +1192,8 @@ enum acpi_srat_type {
>  	ACPI_SRAT_TYPE_MEMORY_AFFINITY = 1,
>  	ACPI_SRAT_TYPE_X2APIC_CPU_AFFINITY = 2,
>  	ACPI_SRAT_TYPE_GICC_AFFINITY = 3,
> -	ACPI_SRAT_TYPE_RESERVED = 4	/* 4 and greater are reserved */
> +	ACPI_SRAT_TYPE_GIC_ITS_AFFINITY = 4,	/* ACPI 6.2 */
> +	ACPI_SRAT_TYPE_RESERVED = 5	/* 5 and greater are reserved */
>  };
>  
>  /*
> @@ -1260,6 +1261,15 @@ struct acpi_srat_gicc_affinity {
>  	u32 clock_domain;
>  };
>  
> +/* 4: GIC ITS Affinity (ACPI 6.2) */
> +
> +struct acpi_srat_its_affinity {
> +	struct acpi_subtable_header header;
> +	u32 proximity_domain;
> +	u16 reserved;
> +	u32 its_id;
> +};
> +
>  /* Flags for struct acpi_srat_gicc_affinity */
>  
>  #define ACPI_SRAT_GICC_ENABLED     (1)	/* 00: Use affinity structure */
> -- 
> 1.8.1.4
> 
