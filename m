From: b-cousson@ti.com (Cousson, Benoit)
Date: Mon, 8 Nov 2010 18:05:53 -0500
Subject: [PATCH 2/6] OMAP3: hwmod data: Add mmu for iva2 and isp
In-Reply-To: <AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
References: <1289006396-27230-1-git-send-email-omar.ramirez@ti.com>	<1289006396-27230-3-git-send-email-omar.ramirez@ti.com>	<4CD5A96D.1000806@ti.com>
	<AANLkTinn4_s-PX08H62AL-tn+8wxXXQjhUNq6d+aDOo+@mail.gmail.com>
Message-ID: <4CD88251.4060400@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/7/2010 11:00 AM, Ramirez Luna, Omar wrote:
> On Sat, Nov 6, 2010 at 2:15 PM, Cousson, Benoit<b-cousson@ti.com>  wrote:
>> On 11/5/2010 9:19 PM, Ramirez Luna, Omar wrote:
>>>
>>> Add mmu hwmod data for iva2 and isp.
>>
>> s/iva2/iva/
>
> Where this terminology can be found? I'm basing this naming on what
> was there or TRM. For omap3 there is no such thing as iva, it is iva2.

IVA2 means IVA v2, before we had an IVA (v1) then IVA v1.1...

The goal is to use the same name for the IP with similar functionality 
across OMAPs version in order to have generic code in the driver.

IVA, IVA2, IVAHD are all doing similar things, so the only way to 
identify the same functionality is by using the same name.
Thanks to the rev field, you can differentiate the various version 
during device creation.
That will allow you to query the hwmod on every version of OMAPs using 
the same "iva" name. Otherwise you will have to use the cpu_is_omap_XXX 
to select iva, iva2 or ivahd depending of the SoC.

Does that make sense to you?

Benoit
