From: rnayak@ti.com (Rajendra Nayak)
Date: Wed, 31 Jul 2013 12:19:22 +0530
Subject: [PATCH v2 1/8] ARM: DRA7: id: Add cpu detection support for DRA7xx
 based SoCs'
In-Reply-To: <20130731064201.GQ7656@atomide.com>
References: <1375183546-12758-1-git-send-email-rnayak@ti.com>
 <1375183546-12758-2-git-send-email-rnayak@ti.com>
 <20130730131009.GA28162@radagast> <51F7CB2F.6070705@ti.com>
 <20130730142353.GL28162@radagast> <51F7CF6F.6050702@ti.com>
 <20130730153138.GA5978@radagast> <51F807EF.6020809@ti.com>
 <51F80939.7060403@ti.com> <51F8A87A.9080002@ti.com>
 <20130731064201.GQ7656@atomide.com>
Message-ID: <51F8B372.2000309@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 31 July 2013 12:12 PM, Tony Lindgren wrote:
> * Rajendra Nayak <rnayak@ti.com> [130730 23:09]:
>>
>> Tony, what do you suggest we do for this series? Since we have just an es1.0 and one board
>> at this point for dra7xx, things would be fine even if we do a dt based parsing to identify
>> the device, and I am fine with it if thats what we feel is the right way forward.
>> For the rest of the DT only platforms (omap4/5/am335x) anyway getting rid of these rev checks
>> from the kernel and depending on DT parsing needs to be a separate series anyway and I dont
>> plan to address those as part of this series.
> 
> Well I'd say there's no need to drop the hardware revision checks
> at this point at least for existing hardware. That's a very minimal
> piece of code and there are way bigger issues to tackle.

right, makes sense.

> 
> For new SoCs, we could do it based on the compatible flag. If it
> helps booting newer hardware with older kernels, then that's a good
> reason to do it.

Sure, we can have dra7xx use the compatible flag and not add all the rev checks.
That said, I would be glad if the latest kernels at least boot on newer hardware
let alone older kernels :) But I guess we have bigger issues to tackle before
even that happens. Thanks for the quick response.

regards,
Rajendra

> 
> Regards,
> 
> Tony
> 
