From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 22 May 2015 11:35:42 +0100
Subject: [PATCH 1/8] of/fdt: split off FDT self reservation from
 memreserve processing
In-Reply-To: <1431326520-17331-2-git-send-email-ard.biesheuvel@linaro.org>
References: <1431326520-17331-1-git-send-email-ard.biesheuvel@linaro.org>
 <1431326520-17331-2-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20150522103541.GU29424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 11, 2015 at 08:41:53AM +0200, Ard Biesheuvel wrote:
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
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

For the arm64 part:

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
