From: julien.grall@citrix.com (Julien Grall)
Date: Wed, 18 Nov 2015 12:16:03 +0000
Subject: [Xen-devel] [PATCH v3 31/62] arm/acpi: Add a helper function
 to get interrupt type
In-Reply-To: <1447753261-7552-32-git-send-email-shannon.zhao@linaro.org>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-32-git-send-email-shannon.zhao@linaro.org>
Message-ID: <564C6C03.5090609@citrix.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/11/15 09:40, shannon.zhao at linaro.org wrote:
> +/**
> + * IRQ line type.
> + *
> + * ACPI_IRQ_TYPE_NONE            - default, unspecified type
> + * ACPI_IRQ_TYPE_EDGE_RISING     - rising edge triggered
> + * ACPI_IRQ_TYPE_EDGE_FALLING    - falling edge triggered
> + * ACPI_IRQ_TYPE_EDGE_BOTH       - rising and falling edge triggered
> + * ACPI_IRQ_TYPE_LEVEL_HIGH      - high level triggered
> + * ACPI_IRQ_TYPE_LEVEL_LOW       - low level triggered
> + * ACPI_IRQ_TYPE_LEVEL_MASK      - Mask to filter out the level bits
> + * ACPI_IRQ_TYPE_SENSE_MASK      - Mask for all the above bits
> + * ACPI_IRQ_TYPE_INVALID         - Use to initialize the type
> + */
> +#define ACPI_IRQ_TYPE_NONE           0x00000000
> +#define ACPI_IRQ_TYPE_EDGE_RISING    0x00000001
> +#define ACPI_IRQ_TYPE_EDGE_FALLING   0x00000002
> +#define ACPI_IRQ_TYPE_EDGE_BOTH                           \
> +    (ACPI_IRQ_TYPE_EDGE_FALLING | ACPI_IRQ_TYPE_EDGE_RISING)
> +#define ACPI_IRQ_TYPE_LEVEL_HIGH     0x00000004
> +#define ACPI_IRQ_TYPE_LEVEL_LOW      0x00000008
> +#define ACPI_IRQ_TYPE_LEVEL_MASK                          \
> +    (ACPI_IRQ_TYPE_LEVEL_LOW | ACPI_IRQ_TYPE_LEVEL_HIGH)
> +#define ACPI_IRQ_TYPE_SENSE_MASK     0x0000000f
> +
> +#define ACPI_IRQ_TYPE_INVALID        0x00000010
> +

Using a separate set of *IRQ_TYPE for ACPI and mixing the DT one is wrong.

Today in Xen we only care about edge vs level, so there is no need to
define so many things.

However, if you really want to keep all these types. It should be
firmware agnostic.

>  #endif /*_ASM_ARM_ACPI_H*/
> 

Regards,

-- 
Julien Grall
