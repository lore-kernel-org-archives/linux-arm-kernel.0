From: balbi@ti.com (Felipe Balbi)
Date: Fri, 19 Aug 2011 00:56:00 +0300
Subject: [PATCH 2/5] ARM: davinci: da850, omapl138: share boot_params
In-Reply-To: <4b305c5bad3d09ba46420ae9a440efb2c7fb88ba.1313702401.git.bengardiner@nanometrics.ca>
References: <cover.1313702401.git.bengardiner@nanometrics.ca>
	<4b305c5bad3d09ba46420ae9a440efb2c7fb88ba.1313702401.git.bengardiner@nanometrics.ca>
Message-ID: <20110818215559.GC21064@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Aug 18, 2011 at 05:50:48PM -0400, Ben Gardiner wrote:
> diff --git a/arch/arm/mach-davinci/include/mach/da850-reference.h b/arch/arm/mach-davinci/include/mach/da850-reference.h
> index d3beb13..6837a98 100644
> --- a/arch/arm/mach-davinci/include/mach/da850-reference.h
> +++ b/arch/arm/mach-davinci/include/mach/da850-reference.h
> @@ -9,6 +9,10 @@
>  #ifndef __ASM_ARCH_DAVINCI_DA850_REFERENCE_H
>  #define __ASM_ARCH_DAVINCI_DA850_REFERENCE_H
>  
> +#include <mach/memory.h>
> +
> +#define DA850_REFERENCE_BOOT_PARAMS (DA8XX_DDR_BASE + 0x100)

why don't you define this at the same location where DA8XX_DDR_BASE is
defined ??

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 490 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110819/5fa701c9/attachment.sig>
