From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 16 Nov 2015 18:49:19 +0000
Subject: [PATCH v2 05/12] arm64/efi: refactor EFI init and runtime code
 for reuse by 32-bit ARM
In-Reply-To: <1447698757-8762-6-git-send-email-ard.biesheuvel@linaro.org>
References: <1447698757-8762-1-git-send-email-ard.biesheuvel@linaro.org>
 <1447698757-8762-6-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151116184919.GD8644@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 16, 2015 at 07:32:30PM +0100, Ard Biesheuvel wrote:
> diff --git a/drivers/firmware/efi/arm-runtime.c b/drivers/firmware/efi/arm-runtime.c
> index e62ee5df96ca..ad11ba6964f6 100644
> --- a/drivers/firmware/efi/arm-runtime.c
> +++ b/drivers/firmware/efi/arm-runtime.c
> @@ -23,18 +23,15 @@
>  
>  #include <asm/cacheflush.h>
>  #include <asm/efi.h>
> -#include <asm/tlbflush.h>
> -#include <asm/mmu_context.h>
> +#include <asm/io.h>

Shouldn't this be linux/io.h ?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
