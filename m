From: grygorii.strashko@ti.com (Grygorii Strashko)
Date: Wed, 17 Jul 2013 15:30:36 +0300
Subject: [PATCH 0/3] ARM: OMAP2+: omap_device: add dynamic pinctrl handling
In-Reply-To: <51E686C1.8020801@ti.com>
References: <1374061312-25469-1-git-send-email-grygorii.strashko@ti.com>
 <51E686C1.8020801@ti.com>
Message-ID: <51E68E6C.60100@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/17/2013 02:57 PM, Roger Quadros wrote:
> Hi Grygorii,
>
> On 07/17/2013 02:41 PM, Grygorii Strashko wrote:
>> Hi Tony, Kevin
>>
>> This patch series introduces dynamic pinctrl handling in OMAP device framework
>> in the same way as it was before switching to DT.
>> This allow OMAP devices driver's developers to simply add dynamic pinctrl
>> handling for "default", "active", "idle", "sleep" PIN states in their drivers
>> by modifying DT definitions only - no modifications in drivers code are not needed.
>>
>
> Overall I like the idea but can we make a provision for device drivers to override
> this default pin state handling?
>
> The OMAP EHCI driver is one such special case where the wakeup mechanism is tied to pinctrl states
> as it uses IO daisy chaining to implement wakeup.
> So depending on whether wakeup needs to be enabled or not I must be able to chose whether
> I put the pin in just "sleep" state or "sleep with wakeup" state.

I think, in this case you can't use default behavior and need to define
custom pins states like "sleep_wakeup"/"sleep_no_wakeup" and do not
define pins state with name "sleep', so Device core and OMAP device
framework will not touch your pins.

>
> cheers,
> -roger
>

Regards,
-grygorii
