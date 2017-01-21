From: wens@csie.org (Chen-Yu Tsai)
Date: Sat, 21 Jan 2017 09:10:36 +0800
Subject: [PATCH v2 00/11] add support for VBUS max current and min voltage
 limits AXP20X and AXP22X PMICs
In-Reply-To: <20170112092821.5xkgpsbbsxaz3s7h@lukather>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
 <20170112092821.5xkgpsbbsxaz3s7h@lukather>
Message-ID: <CAGb2v679kG8eisNa=Bmo+o0DVm7xn7x=N9i7H7mB5n_Y2X=qLw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Thu, Jan 12, 2017 at 5:28 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Fri, Dec 09, 2016 at 12:04:08PM +0100, Quentin Schulz wrote:
>> The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
>> VBUS power supply for both max current and min voltage supplied. This
>> series of patch adds the possibility to set these limits from sysfs.
>>
>> Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
>> the former can set the VBUS power supply max current to 100mA, unlike
>> the latter. The AXP223 VBUS power supply driver used to probe on the
>> AXP221 compatible. This series of patch introduces a new compatible for
>> the AXP223 to be able to set the current max limit to 100mA.
>>
>> With that new compatible, boards having the AXP223 see their DT updated
>> to use the VBUS power supply driver with the correct compatible.
>>
>> This series of patch also migrates from of_device_is_compatible function
>> to the data field of of_device_id to identify the compatible used to
>> probe. This improves the code readability.
>>
>> Mostly cosmetic changes in v2 and adding volatile and writeable regs to
>> AXP20X and AXP22X MFD cells for the VBUS power supply driver.
>
> Applied all the DT patches. I also fixed all the prefixes. Please make
> sure to look at what prefixes are used by a given subsystem next time.

I'm not seeing the DT patches. FYI the old DT does not work with the
new kernel driver updates. Because of the new AXP223 specific compatible
for the usb-power-supply, the updated mfd driver cannot match the old
device node, and the probe will fail at

        if (!of_device_is_available(pdev->dev.of_node))
                return -ENODEV;

I don't see an easy way out of this though. The mfd_cell structure only
takes one compatible string.

Regards
ChenYu

> Thanks!
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
