From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 13 Dec 2016 12:31:22 +0000
Subject: [PATCHv5 06/11] arm64: Use __pa_symbol for kernel symbols
In-Reply-To: <1481068257-6367-7-git-send-email-labbott@redhat.com>
References: <1481068257-6367-1-git-send-email-labbott@redhat.com>
 <1481068257-6367-7-git-send-email-labbott@redhat.com>
Message-ID: <20161213123122.GA24607@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 06, 2016 at 03:50:52PM -0800, Laura Abbott wrote:
> 
> __pa_symbol is technically the marcro that should be used for kernel
> symbols. Switch to this as a pre-requisite for DEBUG_VIRTUAL which
> will do bounds checking.
> 
> Tested-by: James Morse <james.morse@arm.com>
> Signed-off-by: Laura Abbott <labbott@redhat.com>

This looks good to me; I have a (very minor) nit below, but either way:

Reviewed-by: Mark Rutland <mark.rutland@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com>

> diff --git a/arch/arm64/kernel/acpi_parking_protocol.c b/arch/arm64/kernel/acpi_parking_protocol.c
> index a32b401..ca880ce 100644
> --- a/arch/arm64/kernel/acpi_parking_protocol.c
> +++ b/arch/arm64/kernel/acpi_parking_protocol.c
> @@ -18,6 +18,7 @@
>   */
>  #include <linux/acpi.h>
>  #include <linux/types.h>
> +#include <linux/mm.h>

Nit: please keep includes alphabetically ordered, at least where they're
ordered today. Some files are already a mess, but it would be nice to
keep the well-ordered ones ordered.

Thanks,
Mark.
