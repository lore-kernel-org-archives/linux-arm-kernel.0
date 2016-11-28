From: nsekhar@ti.com (Sekhar Nori)
Date: Mon, 28 Nov 2016 13:28:15 +0530
Subject: [PATCH] ARM: dts: da850: specify the maximum bandwidth for tilcdc
In-Reply-To: <953743fb-54f9-fa6f-bfdd-43d92271864f@ti.com>
References: <1480088245-8368-1-git-send-email-bgolaszewski@baylibre.com>
 <8829c208-0674-43c0-8449-ef764071583f@ti.com>
 <953743fb-54f9-fa6f-bfdd-43d92271864f@ti.com>
Message-ID: <86f2b643-c270-1483-4f35-5bdf399a5919@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 28 November 2016 01:12 PM, Tomi Valkeinen wrote:
> On 28/11/16 07:24, Sekhar Nori wrote:
>> On Friday 25 November 2016 09:07 PM, Bartosz Golaszewski wrote:
>>> It has been determined that the maximum resolution supported correctly
>>> by tilcdc rev1 on da850 SoCs is 800x600 at 60. Due to memory throughput
>>> constraints we must filter out higher modes.
>>>
>>> Specify the max-bandwidth property for the display node for
>>> da850-based boards.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
>>> ---
>>>  arch/arm/boot/dts/da850.dtsi | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>> index 8e30d9b..9b7c444 100644
>>> --- a/arch/arm/boot/dts/da850.dtsi
>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>> @@ -452,6 +452,7 @@
>>>  			compatible = "ti,da850-tilcdc";
>>>  			reg = <0x213000 0x1000>;
>>>  			interrupts = <52>;
>>> +			max-bandwidth = <28800000>;
>>
>> If this is effectively the max pixel clock that the device supports,
>> then why not use the datasheet specified value of 37.5 MHz (Tc = 26.66 ns).
> 
> There's a separate property for max-pixelclock. This one is maximum
> pixels per second (which does sound almost the same), but the doc says
> it's about the particular memory interface + LCDC combination.

DA850 supports both mDDR and DDR2, at slightly different speeds. So
memory bandwidth limitation is also board specific. This should probably
move to board file.

But I would like to know why using max-pixelclock is not good enough.
Have experiments shown that LCDC on DA850 LCDK underflows even if pixel
clock is below the datasheet recommendation?

Thanks,
Sekhar
