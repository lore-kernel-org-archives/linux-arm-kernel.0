From: nm@ti.com (Nishanth Menon)
Date: Mon, 10 Jan 2011 08:23:09 -0600
Subject: [PATCH v4 1/3] omap3: beaglexm: fix EHCI power up GPIO dir
In-Reply-To: <alpine.DEB.1.10.1101101442460.18906@esdhcp041196.research.nokia.com>
References: <[PATCH v3 0/3] OMAP3: beaglexm: GPIO fixes>
	<1294441282-17986-2-git-send-email-nm@ti.com>
	<alpine.DEB.1.10.1101101442460.18906@esdhcp041196.research.nokia.com>
Message-ID: <4D2B164D.3060907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Aaro Koskinen had written, on 01/10/2011 06:44 AM, the following:
> Hi,
> 
> On Fri, 7 Jan 2011, Nishanth Menon wrote:
>> From: Koen Kooi <koen@beagleboard.org>
>>
>> EHCI enable power pin is inverted (active high) in comparison
>> to vanilla beagle which is active low. Handle this case conditionally.
>>
>> Without this fix, Beagle XM 4 port EHCI will not function and no
>> networking will be available
>>
>> [nm at ti.com: split up, added descriptive changelogs]
>> Signed-off-by: Nishanth Menon <nm@ti.com>
>> Signed-off-by: Koen Kooi <koen@beagleboard.org>
>> ---
>> arch/arm/mach-omap2/board-omap3beagle.c |    9 ++++++++-
>> 1 files changed, 8 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/arm/mach-omap2/board-omap3beagle.c 
>> b/arch/arm/mach-omap2/board-omap3beagle.c
>> index 6c12760..1b5aa7a 100644
>> --- a/arch/arm/mach-omap2/board-omap3beagle.c
>> +++ b/arch/arm/mach-omap2/board-omap3beagle.c
>> @@ -297,9 +297,16 @@ static int beagle_twl_gpio_setup(struct device *dev,
>>     gpio_request(gpio + 1, "EHCI_nOC");
>>     gpio_direction_input(gpio + 1);
>>
>> -    /* TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, active 
>> low) */
>> +    /*
>> +     * TWL4030_GPIO_MAX + 0 == ledA, EHCI nEN_USB_PWR (out, XM active
>> +     * high / others active low)
>> +     */
>>     gpio_request(gpio + TWL4030_GPIO_MAX, "nEN_USB_PWR");
>>     gpio_direction_output(gpio + TWL4030_GPIO_MAX, 0);
> 
> This call should be deleted.

yikes. yep. thanks for catching.


-- 
Regards,
Nishanth Menon
