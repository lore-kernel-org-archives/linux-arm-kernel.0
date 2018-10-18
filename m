From: guohanjun@huawei.com (Hanjun Guo)
Date: Thu, 18 Oct 2018 20:54:40 +0800
Subject: [PATCH 3/4] irqchip/mbigen: add support for a MBIGEN generating
 SPIs
In-Reply-To: <223d7d7f-54b4-fd7f-1f83-95c9476136b7@arm.com>
References: <1539681316-19300-1-git-send-email-yangyingliang@huawei.com>
 <1539681316-19300-4-git-send-email-yangyingliang@huawei.com>
 <a8ea3f08-8d60-13bf-edcc-03298a9cfb0d@arm.com> <5BC800EB.5070201@huawei.com>
 <15c4ab00-3bfa-0eb8-a341-fc7a2be857f7@arm.com>
 <df892248-4f9c-c095-df9b-885f1e650ba0@huawei.com>
 <223d7d7f-54b4-fd7f-1f83-95c9476136b7@arm.com>
Message-ID: <fde290c2-01e3-d5a8-eaa9-e7faaabf84ec@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 2018/10/18 19:56, Marc Zyngier wrote:
> Hi Hanjun,
> 
> On 18/10/18 12:20, Hanjun Guo wrote:
>> Hi Marc,
>>
>>>>>>
>>>>> Now, the biggest question of them all: how does it work with ACPI? Last
>>>>> time I checked, there was no DT support for platforms using the MBIGEN.
>>>> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/arch/arm64/boot/dts/hisilicon/hip07.dtsi
>>>> This DT describes how platform devices using the MBIGEN.
>>>
>>> That's not how my own D05 boots. It is ACPI only. How is that going to
>>> work on this platform?
>>
>> D05 is ACPI only so it has no dtb in the firmware, that's why we can
>> boot D05 without acpi=on in the boot cmdline, but if you want to
>> boot D05 with dtb, you could try to specify the dtb in the grub
>> (seems centos based):
>>
>> menuentry "example" --id example{
>>         linux /Image-kernel root=... rdinit=...
>>         initrd /example.img
>>         devicetree /d05.dtb
>> }
> 
> Sure. But what I'm asking here is how this change in the MBIGEN driver
> can be beneficial to people who need ACPI, for better or worse? For
> example, you cannot get the PCIe SMMU without ACPI. Good-bye VFIO.
> 
> If it is DT only, I seriously doubt anyone will be able to use it.

We have another ARM64 SoC for wireless base station which with the
same CPU DIE but different IO DIE, they share the same mbigen controller.

Since we use big-endian on wireless base station so only DT is available
(EFI stub is little-endian), we need to reuse this mbigen driver
on this SoC (not the one for D05) as well, not sure if this makes sense
to you, please let us know.

Thanks
Hanjun
