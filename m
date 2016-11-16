From: abailon@baylibre.com (Alexandre Bailon)
Date: Wed, 16 Nov 2016 11:47:19 +0100
Subject: [PATCH v4 4/4] ARM: dts: da850: Add the usb otg device node
In-Reply-To: <d4c8da0e-d66d-1268-78e5-d994399c9166@ti.com>
References: <1478188752-22447-1-git-send-email-abailon@baylibre.com>
 <1478188752-22447-5-git-send-email-abailon@baylibre.com>
 <0c94c5e0-9d2c-fff5-1213-2fb2adb20ab0@ti.com>
 <d2050c80-255e-25d6-99ba-7634f2c7e39a@baylibre.com>
 <d4c8da0e-d66d-1268-78e5-d994399c9166@ti.com>
Message-ID: <70fbd003-18f0-8ceb-650e-c8fcd29531a9@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2016 11:41 AM, Sekhar Nori wrote:
> On Wednesday 16 November 2016 04:05 PM, Alexandre Bailon wrote:
>> On 11/15/2016 11:46 AM, Sekhar Nori wrote:
>>> On Thursday 03 November 2016 09:29 PM, Alexandre Bailon wrote:
>>>> This adds the device tree node for the usb otg
>>>> controller present in the da850 family of SoC's.
>>>> This also enables the otg usb controller for the lcdk board.
>>>>
>>>> Signed-off-by: Alexandre Bailon <abailon@baylibre.com>
>>>> ---
>>>>  arch/arm/boot/dts/da850-lcdk.dts |  8 ++++++++
>>>>  arch/arm/boot/dts/da850.dtsi     | 15 +++++++++++++++
>>>>  2 files changed, 23 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/da850-lcdk.dts b/arch/arm/boot/dts/da850-lcdk.dts
>>>> index 7b8ab21..9f5040c 100644
>>>> --- a/arch/arm/boot/dts/da850-lcdk.dts
>>>> +++ b/arch/arm/boot/dts/da850-lcdk.dts
>>>> @@ -158,6 +158,14 @@
>>>>  	rx-num-evt = <32>;
>>>>  };
>>>>  
>>>> +&usb_phy {
>>>> +	status = "okay";
>>>> +	};
>>>
>>> As mentioned by David already, this node needs to be removed. Please
> 
>> I have missed it. But why should I remove it?
>> Without it, usb otg won't work.
> 
> Grr, I replied to the wrong hunk. The part in da850-lcdk.dts needs to be
> preserved (but please fix the indentation on the closing brace).
OK. Thanks for the confirmation.
> 
> The part in da850.dtsi needs to be removed as it is already merged.
> 
> Thanks,
> Sekhar
> 
