From: rogerq@ti.com (Roger Quadros)
Date: Tue, 13 Dec 2016 16:55:42 +0200
Subject: [PATCH v2 3/9] ARM: dts: dra72: Add separate dtsi for tps65917
In-Reply-To: <91b4075f-2dfb-0d17-592d-f99b91ace590@ti.com>
References: <20161021103841.8044-1-lokeshvutla@ti.com>
 <20161021103841.8044-4-lokeshvutla@ti.com>
 <045e8200-69bd-8590-1da4-96235444db4c@ti.com>
 <91b4075f-2dfb-0d17-592d-f99b91ace590@ti.com>
Message-ID: <ec0a127f-c6e1-cb9c-b369-deece94cb858@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Lokesh,

On 13/12/16 15:08, Lokesh Vutla wrote:
> 
> 
> On Tuesday 13 December 2016 06:10 PM, Roger Quadros wrote:
>> +Tomi, Kishon, Carlos
>>  
>> Hi,
>>
>> On 21/10/16 13:38, Lokesh Vutla wrote:
>>> dra72-evm-common.dtsi consolidates dra72-evm.dts and dra72-evm-revc.dts
>>> which also include tps65917 pmic support as both the evms uses the same
>>> pmic. But, dra71-evm has mostly similar features with a different pmic.
>>> In order to exploit dra72-evm-common.dtsi, creating a separate dtsi
>>> for tps65915 support and including it in respective board files.
>>>
>>> Signed-off-by: Lokesh Vutla <lokeshvutla@ti.com>
>>> ---
>>>  arch/arm/boot/dts/dra72-evm-common.dtsi   | 128 ----------------------------
>>>  arch/arm/boot/dts/dra72-evm-revc.dts      |  21 +++--
>>>  arch/arm/boot/dts/dra72-evm-tps65917.dtsi | 134 ++++++++++++++++++++++++++++++
>>>  arch/arm/boot/dts/dra72-evm.dts           |  14 ++--
>>>  4 files changed, 154 insertions(+), 143 deletions(-)
>>>  create mode 100644 arch/arm/boot/dts/dra72-evm-tps65917.dtsi
>>>
>>
>> This patch breaks USB XHCI and boot on dra72-evm (both revC and non revC)
>>
>> I'll explain why below.
>>
>> [   13.625167] Unhandled fault: imprecise external abort (0x1406) at 0x00000000
>> [   13.632557] pgd = ede10000
>> [   13.635390] [00000000] *pgd=00000000
>> [   13.639145] Internal error: : 1406 [#1] SMP ARM
>> [   13.643893] Modules linked in: xhci_plat_hcd(+) xhci_hcd usbcore omapfb dwc3 cfbfillrect snd_soc_davinci_mcasp cfbimgblt cfbcopyarea udc_core connector_hdmi encoder_tpd12s015 snd_soc_edma m25p80 snd_soc_simpe
>> [   13.695557] CPU: 0 PID: 440 Comm: modprobe Not tainted 4.9.0-rc1 #1050
>> [   13.702399] Hardware name: Generic DRA72X (Flattened Device Tree)
>> [   13.708786] task: edb5c040 task.stack: edd10000
>> [   13.713540] PC is at _raw_spin_unlock_irqrestore+0x0/0x44
>> [   13.719219] LR is at xhci_hub_control+0xc2c/0x15e0 [xhci_hcd]
>> [   13.725242] pc : [<c07df718>]    lr : [<bf486300>]    psr: a0000093
>> [   13.725242] sp : edd118c0  ip : c0e306b4  fp : 00000000
>> [   13.737278] r10: 00000000  r9 : 60000013  r8 : edf28218
>> [   13.742753] r7 : edf28000  r6 : 00000000  r5 : 00000000  r4 : edf2a000
>> [   13.749593] r3 : 00000000  r2 : 00000000  r1 : 60000013  r0 : edf28218
> 
> Hmm.. Thanks for catching it. I remember it was booting when I tested,
> not sure how I missed this :(. usb2_phy1 & 2, mmc and dss supplies needs
> to be added in dra72-evm-tps65917.dtsi file.

OK.
> 
> Tony,
> 	Do you want me to resend this patch or fixup patch on top of this?

In case you send a new patch. please add

Reported-by: Carlos Hernandez <ceh@ti.com>

Thanks.

cheers,
-roger
