From: josh.wu@atmel.com (Josh Wu)
Date: Mon, 11 Feb 2013 11:44:01 +0800
Subject: [PATCH 0/5 v3] at91: PMECC: enable PMECC in dt for at91sam9x5ek,
 at91sam9n12ek
In-Reply-To: <20130210004010.GE16278@quad.lixom.net>
References: <1358945232-2282-1-git-send-email-josh.wu@atmel.com>
 <5113D347.8050409@atmel.com> <20130210004010.GE16278@quad.lixom.net>
Message-ID: <51186901.9060400@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Olof

On 2/10/2013 8:40 AM, Olof Johansson wrote:
> On Thu, Feb 07, 2013 at 05:16:07PM +0100, Nicolas Ferre wrote:
>> On 01/23/2013 01:47 PM, Josh Wu :
>>> Those patches will enable PMECC in dt parameters for at91sam9x5ek and
>>> at91sam9n12ek.
>>>
>>> The PMECC driver will check minimum required ecc on ONFI parameter from NAND
>>> flash.
>>>
>>> If pmecc-cap, pmecc-sector-size in dts file is specified, use those two.
>>> otherwise, set those according to NAND flash ONFI parameters.
>>>
>>> If the pmecc-cap, pmecc-sector-size in dts are different with ecc requirement
>>> in ONFI, print out a warning.
>>>
>>>
>>> For the following compile error:
>>>    ERROR (phandle_references): Reference to non-existent node or label "pinctrl_ssc0_tx"
>>>
>>>    ERROR: Input tree has errors, aborting (use -f to force output)
>>>    make[2]: *** [arch/arm/boot/dts/at91sam9g20ek.dtb] Error 2
>>>
>>> the fixes are already merged in Linux mainline in v3.8-rc4.
>>> you can find in:
>>>   544ae6b2e676c3c37fb8c93ef9327932fc2e5bc2 (ARM: at91/dts: add pinctrl support for SSC peripheral)
>>>   ea03c81521bde526570e1dec96eaa21fe5ac84a2 (ASoC: atmel-ssc: add pinctrl selection to driver)
>> Artem,
>>
>> I propose to take patches 2 and 3/5 of this series via arm-soc git tree.
>> I will specify to merge them at the end of the merge-window so that the
>> Device Tree properties will not be out-of-sync with driver modifications
>> (may not cause big issues anyway).
> I'm not cc:d on the patches, but if it's just new properties then there's
> no reason to hold off to "late in the merge window". There's actually no
> way for you to hold that off yourself, since we won't accept new patches
> to arm-soc that late.
>
> I don't see any cc to devicetree-discuss of the device tree bindings
> though, and no update of Documentation/device-tree/bindings/, so the
> patches are not ready to go in yet.

Since in my commit: a41b51a1f7c15a1b00f30a3ad2d0373ad51b883d (mtd: at91: 
add dt parameters for Atmel PMECC), it already added following 
properties to DT documentation:
   atmel,pmecc-cap
   atmel,pmecc-sector-size
   atmel,pmecc-lookup-table-offset
so in this patches series, NO. 2 and 3 just add it to at91 board's dts 
file according to the DT documentation.

Indeed, this patch series make a little bit different from the DT 
documentation, that is: the ROM code mapping size are smaller than the 
DT documentation example.
But original DT documentation example still works.

So I think the DT documentation's explanation are proper for this patch 
series. It seems I don't have to update the DT documentation so far.

>
>
> -Olof

Best Regards,
Josh Wu
