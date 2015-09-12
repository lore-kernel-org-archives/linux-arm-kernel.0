From: nsekhar@ti.com (Sekhar Nori)
Date: Sat, 12 Sep 2015 16:51:12 +0530
Subject: [PATCH v2 00/23] dmaengine/ARM: Merge the edma drivers into one
In-Reply-To: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
References: <1441974442-8233-1-git-send-email-peter.ujfalusi@ti.com>
Message-ID: <55F40AA8.9050706@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 September 2015 05:56 PM, Peter Ujfalusi wrote:
> Hi,
> 
> Changes since v1:
> - Convert edma platform device registration to use platform_device_register_full
> - Moved the PM callback also to the dmaengine driver - missed in v1
> - Commit message added to:
>   ARM/dmaengine: edma: Remove limitation on the number of eDMA controllers
> - New patch which reads the flag for the channel mapping support in one place
> 
> Cover letter:
> 
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

I looked at the series, it looks pretty good. Thanks for getting it done!

No problem with entire series going through dmaengine. The week after
next, when I am back in office, I would like to test on DM365 as well.
But really no need to wait for it if the series is ready otherwise.

Thanks,
Sekhar
