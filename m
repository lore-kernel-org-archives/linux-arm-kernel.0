From: olof@lixom.net (Olof Johansson)
Date: Sun, 10 Nov 2013 10:20:57 -0800
Subject: [PATCH] ARM: vt8500: add defconfig
In-Reply-To: <527FC875.7080402@prisktech.co.nz>
References: <1384057450-23640-1-git-send-email-olof@lixom.net>
 <527FC875.7080402@prisktech.co.nz>
Message-ID: <CAOesGMiVcYgPa+YOGWzs6YdkzFmajDgD9W-DwRT=FkUZmqB0-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Nov 10, 2013 at 9:55 AM, Tony Prisk <linux@prisktech.co.nz> wrote:
> On 10/11/13 17:24, Olof Johansson wrote:
>>
>> Add a single-vendor config for vt8500. We can't enable WM8750 in
>> multi_v7_defconfig since it's a v6-based device, but it's still valuable
>> to have an in-tree defconfig that is suitable for the hardware.
>>
>> This is based on multi_v7_defconfig and can be tweaked over time. It
>> gets us off the ground for now.
>>
>> Booted on an APC8750 with USB rootfs.
>>
>> Signed-off-by: Olof Johansson <olof@lixom.net>
>> ---
>>
>> Tony,
>>
>>
>> I'll apply this to a suitable arm-soc branch sometime during the merge
>> window,
>> since it doesn't affect existing systems. A review/ack would be
>> appreciated!
>>
>>
>> -Olof
>>
>>   arch/arm/configs/vt8500_defconfig |   88
>> +++++++++++++++++++++++++++++++++++++
>>   1 file changed, 88 insertions(+)
>>   create mode 100644 arch/arm/configs/vt8500_defconfig
>>
>> diff --git a/arch/arm/configs/vt8500_defconfig
>> b/arch/arm/configs/vt8500_defconfig
>> new file mode 100644
>> index 0000000..6fd3717
>> --- /dev/null
>> +++ b/arch/arm/configs/vt8500_defconfig
>> @@ -0,0 +1,88 @@
>> +CONFIG_IRQ_DOMAIN_DEBUG=y
>> +CONFIG_NO_HZ=y
>> +CONFIG_HIGH_RES_TIMERS=y
>> +CONFIG_BLK_DEV_INITRD=y
>> +CONFIG_ARCH_MULTI_V6=y
>> +CONFIG_ARCH_WM8750=y
>> +CONFIG_ARCH_WM8850=y
>> +CONFIG_ARM_ERRATA_720789=y
>> +CONFIG_ARM_ERRATA_754322=y
>> +CONFIG_ARM_ERRATA_775420=y
>> +CONFIG_HAVE_ARM_ARCH_TIMER=y
>> +CONFIG_AEABI=y
>> +CONFIG_HIGHMEM=y
>> +CONFIG_HIGHPTE=y
>> +CONFIG_ARM_APPENDED_DTB=y
>> +CONFIG_ARM_ATAG_DTB_COMPAT=y
>> +CONFIG_VFP=y
>> +CONFIG_NEON=y
>> +CONFIG_PM_RUNTIME=y
>> +CONFIG_NET=y
>> +CONFIG_UNIX=y
>> +CONFIG_INET=y
>> +CONFIG_IP_PNP=y
>> +CONFIG_IP_PNP_DHCP=y
>> +CONFIG_DEVTMPFS=y
>> +CONFIG_DEVTMPFS_MOUNT=y
>> +CONFIG_PROC_DEVICETREE=y
>> +CONFIG_EEPROM_93CX6=y
>> +CONFIG_SCSI=y
>> +CONFIG_BLK_DEV_SD=y
>> +CONFIG_NETDEVICES=y
>> +# CONFIG_NET_CADENCE is not set
>> +# CONFIG_NET_VENDOR_BROADCOM is not set
>> +# CONFIG_NET_VENDOR_CIRRUS is not set
>> +# CONFIG_NET_VENDOR_FARADAY is not set
>> +# CONFIG_NET_VENDOR_INTEL is not set
>> +# CONFIG_NET_VENDOR_MARVELL is not set
>> +# CONFIG_NET_VENDOR_MICREL is not set
>> +# CONFIG_NET_VENDOR_NATSEMI is not set
>> +# CONFIG_NET_VENDOR_SEEQ is not set
>> +# CONFIG_NET_VENDOR_SMSC is not set
>> +# CONFIG_NET_VENDOR_STMICRO is not set
>> +CONFIG_VIA_VELOCITY=y
>> +# CONFIG_NET_VENDOR_WIZNET is not set
>> +CONFIG_PHYLIB=y
>> +CONFIG_INPUT_MATRIXKMAP=y
>> +CONFIG_SERIAL_VT8500=y
>> +CONFIG_SERIAL_VT8500_CONSOLE=y
>> +CONFIG_PINCTRL_SINGLE=y
>> +CONFIG_PINCTRL_WM8750=y
>> +CONFIG_GPIO_GENERIC_PLATFORM=y
>> +CONFIG_POWER_SUPPLY=y
>> +CONFIG_POWER_RESET=y
>> +CONFIG_MFD_SYSCON=y
>> +CONFIG_REGULATOR=y
>> +CONFIG_REGULATOR_FIXED_VOLTAGE=y
>> +CONFIG_REGULATOR_GPIO=y
>> +CONFIG_USB=y
>> +CONFIG_USB_EHCI_HCD=y
>> +CONFIG_USB_EHCI_HCD_PLATFORM=y
>> +CONFIG_USB_UHCI_HCD=y
>> +CONFIG_USB_STORAGE=y
>> +CONFIG_NOP_USB_XCEIV=y
>> +CONFIG_USB_GPIO_VBUS=y
>> +CONFIG_USB_ULPI=y
>> +CONFIG_MMC=y
>> +CONFIG_MMC_DEBUG=y
>> +CONFIG_NEW_LEDS=y
>> +CONFIG_LEDS_CLASS=y
>> +CONFIG_LEDS_TRIGGERS=y
>> +CONFIG_RTC_CLASS=y
>> +CONFIG_RTC_DRV_VT8500=y
>> +CONFIG_DMADEVICES=y
>> +CONFIG_COMMON_CLK_DEBUG=y
>> +# CONFIG_IOMMU_SUPPORT is not set
>> +CONFIG_PWM=y
>> +CONFIG_PWM_VT8500=y
>> +CONFIG_RESET_CONTROLLER=y
>> +CONFIG_GENERIC_PHY=y
>> +CONFIG_EXT4_FS=y
>> +CONFIG_TMPFS=y
>> +CONFIG_NFS_FS=y
>> +CONFIG_NFS_V3_ACL=y
>> +CONFIG_NFS_V4=y
>> +CONFIG_ROOT_NFS=y
>> +CONFIG_PRINTK_TIME=y
>> +CONFIG_DEBUG_KERNEL=y
>> +CONFIG_LOCKUP_DETECTOR=y
>
>
> I notice you left out the I2C driver and the MMC driver - given you had/have
> problems with them this is understandable. They can be sorted out later.

MMC defaults to on, so it's not in the defconfig but will be in the
actual config.

I2C is off by accident here, thanks for catching that -- I'll revise
and enable that.

> My main concern is that this file is named 'vt8500_defconfig', but it won't
> be able to cover all of the VT8500 'family'.
> The earlier models (vt8500/wm8505) are ARM9, the WM8650 was ARM11, and then
> we got to the WM8750 that you are targetting (ARMv6) and finally the ARMv7
> stuff (WM8850/WM8950).
> I'm not particularly fussed about it (it's fine as is), but if you think of
> a better filename to fit the situation I wouldn't complain :)
>
> Reviewed-by: Tony Prisk <linux@prisktech.co.nz>

Good point -- let's go with vt8500_v6_v7_defconfig and if desired a
v4_v5 (or v5-only, it seems)? That's similar to how i.MX has handled
it.


-Olof
