From: nsekhar@ti.com (Sekhar Nori)
Date: Wed, 7 Oct 2015 16:13:23 +0530
Subject: [PATCH v4 00/25] dmaengine/ARM: Merge the edma drivers into one
In-Reply-To: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
References: <1443088932-21731-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <5614F74B.206@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 24 September 2015 03:31 PM, Peter Ujfalusi wrote:

> with this series the edma two driver setup will be changed to have only one
> driver to support eDMA3. The legacy edma interface will be removed and eDMA can
> only be used via dmaengine API from this point on.
> In order to do the merge the following improvements has been done:
> - One driver instance per eDMA:
>  - Any number of eDMA instances are supported (both legacy and DT boot)
> - Not relying on global variables, arrays, etc
> - Code simplification and optimizations in several places
> 
> This change will also help us to do bigger changes in the eDMA driver since,
> since now we have only one driver to work with.
> 
> The series has been tested on:
> da850-evm (OMAP-L138)
> - with legacy and DT boot (both eDMA0 and eDMA1 is enabled)
> - In code swapping the eDMA instances in legacy mode to make sure the second
>   instance is handled correctly.
> 
> am335x-evmsk
> - DT boot
> 
> I think this series could go via the dmaengine tree. Changes are trivial under
> arch/arm/

I tested this series on DM6446 EVM using MMC/SD as EDMA client. It
worked well. For the arch/arm/mach-davinci parts, please add

Acked-by: Sekhar Nori <nsekhar@ti.com>

Vinod, if you prefer me replying with acks on individual patches, I can
do that too.

Regards,
Sekhar
