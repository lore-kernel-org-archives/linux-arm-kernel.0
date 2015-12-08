From: yankejian@huawei.com (Yankejian (Hackim Yim))
Date: Tue, 8 Dec 2015 09:45:00 +0800
Subject: [PATCH RESEND net-next 3/3] arm64: hip05-d02: Document devicetree
 bindings for Hisilicon D02 Board
In-Reply-To: <56658E36.40702@huawei.com>
References: <1449302088-53037-1-git-send-email-yankejian@huawei.com>
 <1449302088-53037-4-git-send-email-yankejian@huawei.com>
 <20151207131617.GA25170@rob-hp-laptop> <56658E36.40702@huawei.com>
Message-ID: <5666361C.3070002@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 2015/12/7 21:48, Bintian wrote:
> On 2015/12/7 21:16, Rob Herring wrote:
>> On Sat, Dec 05, 2015 at 03:54:48PM +0800, yankejian wrote:
>>> This patch adds documentation for the devicetree bindings used by the
>>> DT files of Hisilicon Hip05-D02 development board.
>>>
>>> Signed-off-by: yankejian <yankejian@huawei.com>
> You may need to configure as  "Kejian Yan <yankejian@huawei.com>"     :)
>
> BR,
>
> Bintian

agree, thanks

BR,
Kejian Yan

>>> ---
>>>   .../devicetree/bindings/arm/hisilicon/hisilicon.txt      | 16 ++++++++++++++++
>>>   1 file changed, 16 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>> index 6ac7c00..5318d78 100644
>>> --- a/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>> +++ b/Documentation/devicetree/bindings/arm/hisilicon/hisilicon.txt
>>> @@ -187,6 +187,22 @@ Example:
>>>           reg = <0xb0000000 0x10000>;
>>>       };
>>>   +Hisilicon HiP05 PERISUB system controller
>>> +
>>> +Required properties:
>>> +- compatible : "hisilicon,peri-c-subctrl", "syscon";
>> This should be more specific and have the SOC name in it.
>>
>>> +- reg : Register address and size
>>> +
>>> +The HiP05 PERISUB system controller is shared by peripheral controllers in
>>> +HiP05 Soc to implement some basic configurations. the peripheral
>>> + controllers include mdio, ddr, iic, uart, timer and so on.
>>> +
>>> +Example:
>>> +    /* for HiP05 PCIe-SAS system */
>>> +    pcie_sas: system_controller at 0xb0000000 {
>>> +        compatible = "hisilicon,pcie-sas-subctrl", "syscon";
>> The example doesn't match.
>>
Thanks for this. I have changed this in PATCH V2 already floated.

BR
Kejian Yan
>>> +        reg = <0xb0000000 0x10000>;
>>> +    };
>>>   -----------------------------------------------------------------------
>>>   Hisilicon CPU controller
>>>   -- 
>>> 1.9.1
>>>
>>> -- 
>>> To unsubscribe from this list: send the line "unsubscribe devicetree" in
>>> the body of a message to majordomo at vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> -- 
>> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> Please read the FAQ at  http://www.tux.org/lkml/
>>
>> .
>>
>
>
>
> .
>
