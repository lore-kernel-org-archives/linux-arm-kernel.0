From: rogerq@ti.com (Roger Quadros)
Date: Mon, 14 Oct 2013 12:31:26 +0300
Subject: [PATCH 3/7] drivers: phy: usb3/pipe3: Adapt pipe3 driver to
 Generic PHY Framework
In-Reply-To: <525BB726.6040100@ti.com>
References: <1378136591-7463-1-git-send-email-kishon@ti.com>
 <1378136591-7463-4-git-send-email-kishon@ti.com> <5231A35D.7060006@ti.com>
 <5236749F.3070707@ti.com> <5236B537.1090902@ti.com> <52581304.9010205@ti.com>
 <525BB726.6040100@ti.com>
Message-ID: <525BB9EE.3010709@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kishon,

On 10/14/2013 12:19 PM, Kishon Vijay Abraham I wrote:
> Hi Roger,
> 
> On Friday 11 October 2013 08:32 PM, Roger Quadros wrote:
>> On 09/16/2013 10:37 AM, Roger Quadros wrote:
>>> On 09/16/2013 06:01 AM, Kishon Vijay Abraham I wrote:
>>>> On Thursday 12 September 2013 04:49 PM, Roger Quadros wrote:
>>>>> Hi Kishon,
>>>>>
>>>>> On 09/02/2013 06:43 PM, Kishon Vijay Abraham I wrote:

>>>>>>   #ifdef CONFIG_OF
>>>>>> -static const struct of_device_id omap_usb3_id_table[] = {
>>>>>> +static const struct of_device_id omap_pipe3_id_table[] = {
>>>>>> +    { .compatible = "ti,omap-pipe3" },
>>>>>
>>>>> why do you need "omap-pipe3", isn't sata, pcie and usb3 sufficient?
>>>>
>>>> I thought it would be better if everyone uses omap-pipe3 and added pcie, sata if there are any specific settings (for pcie or sata) that should be done.
>>>
>>> We can always add specialized options later when needed. AFAIK just the
>>> DPLL data is different among the different PHYs.
>>>>>
>>>>>> +    { .compatible = "ti,omap-sata" },
>>>>>> +    { .compatible = "ti,omap-pcie" },
>>>>>>       { .compatible = "ti,omap-usb3" },
>>>
>>> I think compatible strings should be improved to indicate that it is a PHY.
>>>
>>> e.g. "ti,omap-phy-sata" or just "ti,pipe3-phy-sata"
>>>
>>
>> Please remove "ti,omap-pcie" for now, you can add it later whenever you add
>> dpll settings for pcie.
>>
>> Also, please change the newly added compatible strings to
>>
>> "ti,phy-pipe3-usb3" and "ti,phy-pipe3-sata"
> 
> No, I think we should have omap in the compatible since this PHY is specific to
> OMAP.

DRA7x and an am43x are not OMAP so I was suggesting not to use it for new PHY types.
We still preserve just "ti,omap-usb3" for backward compatibility.

cheers,
-roger
