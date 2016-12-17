From: sre@kernel.org (Sebastian Reichel)
Date: Sat, 17 Dec 2016 16:54:31 +0100
Subject: [PATCH v2 00/11] add support for VBUS max current and min
 voltage limits AXP20X and AXP22X PMICs
In-Reply-To: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
References: <20161209110419.28981-1-quentin.schulz@free-electrons.com>
Message-ID: <20161217155431.jlkxxdgxzu5aiuke@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Quentin,

On Fri, Dec 09, 2016 at 12:04:08PM +0100, Quentin Schulz wrote:
> The X-Powers AXP209 and AXP20X PMICs are able to set a limit for the
> VBUS power supply for both max current and min voltage supplied. This
> series of patch adds the possibility to set these limits from sysfs.
> 
> Also, the AXP223 PMIC shares most of its behaviour with the AXP221 but
> the former can set the VBUS power supply max current to 100mA, unlike
> the latter. The AXP223 VBUS power supply driver used to probe on the
> AXP221 compatible. This series of patch introduces a new compatible for
> the AXP223 to be able to set the current max limit to 100mA.
> 
> With that new compatible, boards having the AXP223 see their DT updated
> to use the VBUS power supply driver with the correct compatible.
> 
> This series of patch also migrates from of_device_is_compatible function
> to the data field of of_device_id to identify the compatible used to
> probe. This improves the code readability.
> 
> Mostly cosmetic changes in v2 and adding volatile and writeable regs to
> AXP20X and AXP22X MFD cells for the VBUS power supply driver.
> 
> Quentin Schulz (11):
>   power: supply: axp20x_usb_power: use of_device_id data field instead
>     of device_is_compatible
>   mfd: axp20x: add volatile and writeable reg ranges for VBUS power
>     supply driver
>   power: supply: axp20x_usb_power: set min voltage and max current from
>     sysfs
>   Documentation: DT: binding: axp20x_usb_power: add axp223 compatible
>   power: supply: axp20x_usb_power: add 100mA max current limit for
>     AXP223
>   mfd: axp20x: add separate MFD cell for AXP223
>   ARM: dtsi: add DTSI for AXP223
>   ARM: dts: sun8i-a33-olinuxino: use AXP223 DTSI
>   ARM: dts: sun8i-a33-sinlinx-sina33: use AXP223 DTSI
>   ARM: dts: sun8i-r16-parrot: use AXP223 DTSI
>   ARM: dtsi: sun8i-reference-design-tablet: use AXP223 DTSI

Thanks for your patchset. We are currently in the merge
window and patches 1 & 3-5 will appear in linux-next once
4.10-rc1 has been tagged by Linus Torvalds.

Until then I queued them into this branch:

https://git.kernel.org/cgit/linux/kernel/git/sre/linux-power-supply.git/log/?h=for-next-next

-- Sebastian

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161217/584ce732/attachment.sig>
