From: jon-hunter@ti.com (Jon Hunter)
Date: Mon, 24 Sep 2012 10:57:50 -0500
Subject: [PATCH V3 1/8] ARM: OMAP3: Add debugss HWMOD data
In-Reply-To: <alpine.DEB.2.00.1209201653020.12583@utopia.booyaka.com>
References: <1347290626-21164-1-git-send-email-jon-hunter@ti.com>
 <1347290626-21164-2-git-send-email-jon-hunter@ti.com>
 <alpine.DEB.2.00.1209191731270.5264@utopia.booyaka.com>
 <alpine.DEB.2.00.1209201653020.12583@utopia.booyaka.com>
Message-ID: <506082FE.8000705@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Paul,

On 09/20/2012 12:13 PM, Paul Walmsley wrote:
> On Wed, 19 Sep 2012, Paul Walmsley wrote:
> 
>> On Mon, 10 Sep 2012, Jon Hunter wrote:
>>
>>> To enable PMU with runtime PM support on OMAP3 devices we need to be able to
>>> dynamically enable and disable the debug sub-system at runtime. By adding HWMOD
>>> data for the debug sub-system for OMAP3, we can build the PMU device using the
>>> debug sub-system HWMOD and control this power domain using runtime PM.
>>>
>>> Reviewed-by: Benoit Cousson <b-cousson@ti.com>
>>> Signed-off-by: Jon Hunter <jon-hunter@ti.com>
>>
>> Isn't this patch missing MPU address ranges?  Looking at the OMAP4 TRM 
>> Table 2-2 "L3_EMU Memory Space Mapping" it should cover 
>> 0x54000000-0x541fffff?
> 
> Looks like Jon is out of the office at the moment.  So this one has been 
> updated locally to add the _OMAP3_ address space from the TRM (my earlier 
> message referred incorrectly to the OMAP4 address space).  Updated patch 
> below.

Thanks for catching that. Was not needed for PMU use-case but I should
have added that for other use-cases.

Cheers
Jon
