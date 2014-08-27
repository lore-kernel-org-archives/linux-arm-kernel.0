From: zhangfei.gao@linaro.org (zhangfei)
Date: Wed, 27 Aug 2014 23:08:08 +0800
Subject: [PATCH 1/6] ARM: dts: hix5hd2: add gmac node
In-Reply-To: <20140827150409.GC9737@leverpostej>
References: <1409143114-23311-1-git-send-email-zhangfei.gao@linaro.org>
 <1409143114-23311-2-git-send-email-zhangfei.gao@linaro.org>
 <20140827145406.GA9737@leverpostej> <53FDF2CC.8080302@linaro.org>
 <20140827150409.GC9737@leverpostej>
Message-ID: <53FDF458.2020601@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 08/27/2014 11:04 PM, Mark Rutland wrote:
> On Wed, Aug 27, 2014 at 04:01:32PM +0100, zhangfei wrote:
>>
>>
>> On 08/27/2014 10:54 PM, Mark Rutland wrote:
>>> On Wed, Aug 27, 2014 at 01:38:29PM +0100, Zhangfei Gao wrote:
>>>> Signed-off-by: Zhangfei Gao <zhangfei.gao@linaro.org>
>>>> ---
>>>>    arch/arm/boot/dts/hisi-x5hd2-dkb.dts |   26 ++++++++++++++++++++++++++
>>>>    arch/arm/boot/dts/hisi-x5hd2.dtsi    |   16 ++++++++++++++++
>>>>    2 files changed, 42 insertions(+)
>>>>
>>>> diff --git a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
>>>> index 05b44c2..0344de0 100644
>>>> --- a/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
>>>> +++ b/arch/arm/boot/dts/hisi-x5hd2-dkb.dts
>>>> @@ -51,3 +51,29 @@
>>>>    &uart0 {
>>>>    	status = "okay";
>>>>    };
>>>> +
>>>> +&gmac0 {
>>>> +	#address-cells = <1>;
>>>> +	#size-cells = <0>;
>>>> +	phy-handle = <&phy2>;
>>>> +	phy-mode = "mii";
>>>> +	mac-address = [00 00 00 00 00 00];
>>>
>>> If this is just so space is pre-allocated for the bootloader to patch
>>> this, please place a comment to that effect.
>>>
>>> Otherwise that doesn't look right.
>>
>> Yes, it is placeholder, bootloader will overwrite field.
>>
>> Also net driver will use random address if if not valid addr.
>> if (!is_valid_ether_addr(ndev->dev_addr))
>> 	eth_hw_addr_random(ndev);	
>
> Sure. All I'm asking for is to have something like:
>
> /* Placeholder, overwritten by bootloader */
> mac-address = [00 00 00 00 00 00];

Got it, will update.
Thanks Mark.
