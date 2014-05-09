From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 09 May 2014 09:24:42 -0600
Subject: [PATCH] ARM: tegra: enable console framebuffer rotation
In-Reply-To: <536CE414.5030406@suse.de>
References: <1399432682-677-1-git-send-email-acourbot@nvidia.com>
 <536A57FA.2090608@wwwdotorg.org> <536AC45F.6080608@nvidia.com>
 <536CE414.5030406@suse.de>
Message-ID: <536CF33A.3020906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/09/2014 08:20 AM, Andreas F?rber wrote:
> Am 08.05.2014 01:40, schrieb Alex Courbot:
>> On 05/08/2014 12:57 AM, Stephen Warren wrote:
>>> On 05/06/2014 09:18 PM, Alexandre Courbot wrote:
>>>> Console rotation is needed for devices like Tegra Note 7 and NVIDIA
>>>> SHIELD to get the boot console in the expected orientation.
>>>
>>> I've squashed this into Tegra's for-3.16/defconfig branch.
>>>
>>> Can you please also update multi_v7_defconfig, and send that change to
>>> arm-soc (arm at kernel.org) to be applied. Thanks.
>>
>> I omitted doing this for now because the devices that require this
>> option (TN7/SHIELD) need a custom build with appended DTB and/or
>> command-line anyway. Therefore they cannot use a multi-mach kernel
> 
> What does appending a .dtb have to do with whether or not to use a
> multi-mach kernel? We package zImage/uImage and .dtbs separately, so
> surely the multi_v7_defconfig should be kept working with Tegra devices.
> Appending a .dtb only comes into play for preparing installation images.

That would be a reasonable argument if generic distro installers or
kernel packages were likely to support the TN7 and SHIELD. However,
given the bootloader situation there and the need for a custom kernel
anyway for APPENDED_DTB, I assume that's not the case on this particular
device?

If you do intend to support this device with SuSe installer and kernel
packages, could you give an outline of how you do so?
