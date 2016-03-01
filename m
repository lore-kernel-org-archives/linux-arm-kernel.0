From: carlo@caione.org (Carlo Caione)
Date: Tue, 1 Mar 2016 13:53:42 +0100
Subject: [PATCH 7/8] ARM64: dts: amlogic: Extend GXBaby GIC node
In-Reply-To: <56D58E88.2080700@arm.com>
References: <1456789465-2962-1-git-send-email-afaerber@suse.de>
 <1456789465-2962-8-git-send-email-afaerber@suse.de>
 <56D57673.8030702@arm.com> <56D57A7F.5020806@suse.de>
 <56D58E88.2080700@arm.com>
Message-ID: <CAOQ7t2aev5fycZxNEkChWkYYVAV3pn9qnsXnO56V6J7Z3Mi-Rg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 1, 2016 at 1:43 PM, Andre Przywara <andre.przywara@arm.com> wrote:
> Hi,
>
> On 01/03/16 11:18, Andreas F?rber wrote:
>> Hi Andre,
>>
>> Am 01.03.2016 um 12:01 schrieb Andre Przywara:
>>> On 29/02/16 23:44, Andreas F?rber wrote:
>>>> Add GICH and GICV resources for HYP mode - guess based on other vendors.
>>>
>>> Do you know if the firmware allows the kernel to be entered in EL2
>>> (which is the arm64 name for HYP)?
>>> So can we run kvm?
>>> If you have a booted kernel, can you grep for "EL2" and "kvm" in the dmesg?
>>
>> I do not have a rootfs yet (MMC v5 patches by Carlo are still waiting
>> for review), but with this change the KVM driver initializes okay - the
>> purpose of this patch!
>>
>>> Also you should merge this patch into 3/8, same for 8/8.
>>
>> If people confirm this is generally or specifically for this SoC correct
>> then sure. So far 3/8 seems a safe subset for lack of public documentation.
>
> The GIC is an integral part of the SoC, so this clearly belongs in there.
>
>>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
>>>> ---
>>>>  arch/arm64/boot/dts/amlogic/meson-gxbb.dtsi | 4 +++-
>
> In general I was wondering if this naming is correct?
> Shouldn't it be something with "s905" in it? Because this the SoC that
> is driving all those hardware and the peripherals that you describe in
> there are clearly within the SoC.
> So something like meson-s905.dtsi or the like?

When I first submitted support for the meson8 and meson8b I picked up
the names according to the Amlogic SDK.
In the latest Amlogic drop this SoC is identified as meson-gxbb so
probably we should stick to this name.

-- 
Carlo Caione
