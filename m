From: lho@apm.com (Loc Ho)
Date: Fri, 8 Jan 2016 16:30:48 -0800
Subject: [PATCH v3 0/2] acpi: apei: Bug fix to enable APEI support for
 ARMv8
In-Reply-To: <1446857519-5908-1-git-send-email-lho@apm.com>
References: <1446857519-5908-1-git-send-email-lho@apm.com>
Message-ID: <CAPw-ZT=Kor1E7NpAkoAyJtULiCGuCCsoSES05Dr6-eUUS8dDHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Borislav/Doung/etc,

> v3
> * Change the title of the patch to reflect the patch
> * Completely dropped the driver. Instead, move completely to the FW by
>   accessing the GIC directly.
> * Fix a bug with function acpi_gsi_to_irq
> * Enable APEI multiple GHES source to share an single external IRQ
>
> v2
> * Make all code more generic naming
> * Still waiting for comment from Linaro folks on APEI
>
> ---
> Loc Ho (2):
>   acpi: Fix proper return code for function acpi_gsi_to_irq
>   acpi: apei: Enable APEI multiple GHES source to share an single
>     external IRQ

It has been awhile and I thought I check again on this. Any issue with
these two changes as it is needed for ARMv8 64-bit APEI support.
Without these two changes, APEI support will NOT work with X-Gene
platforms.

-Loc
