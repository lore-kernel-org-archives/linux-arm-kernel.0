From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 1 Jun 2015 18:33:30 +0100
Subject: [PATCH for-v4.2 1/4] of/fdt: split off FDT self reservation from
 memreserve processing
In-Reply-To: <1433158834-25238-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1433158834-25238-1-git-send-email-ard.biesheuvel@linaro.org>
 <1433158834-25238-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150601173330.GE14192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 01, 2015 at 01:40:31PM +0200, Ard Biesheuvel wrote:
> This splits off the reservation of the memory occupied by the FDT
> binary itself from the processing of the memory reservations it
> contains. This is necessary because the physical address of the FDT,
> which is needed to perform the reservation, may not be known to the
> FDT driver core, i.e., it may be mapped outside the linear direct
> mapping, in which case __pa() returns a bogus value.
> 
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Acked-by: Rob Herring <robh@kernel.org>
> Acked-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  arch/arm/mm/init.c         |  1 +
>  arch/arm64/mm/init.c       |  1 +
>  arch/powerpc/kernel/prom.c |  1 +
>  drivers/of/fdt.c           | 19 ++++++++++++++-----
>  include/linux/of_fdt.h     |  2 ++
>  5 files changed, 19 insertions(+), 5 deletions(-)

I'm happy to take this patch (already acked by the DT maintainers)
through the arm64 tree but it would be good to have an ack from the arch
maintainers as well (i.e. Russell, Ben, Paul).

Thanks.

-- 
Catalin
