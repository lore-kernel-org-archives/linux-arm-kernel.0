From: agraf@suse.de (Alexander Graf)
Date: Thu, 5 Oct 2017 15:06:34 +0200
Subject: [PATCH 2/2] arm64: dts: qcom: Rename SBC to DragonBoard 410c
In-Reply-To: <CAAqcGH=aZSg7Dzv_Y2erUxmCaN7LXYqxgO9wnPKqSVX1fBuCMg@mail.gmail.com>
References: <20171003091155.7138-1-linus.walleij@linaro.org>
 <20171003091155.7138-2-linus.walleij@linaro.org>
 <b6b065c7-ad6b-d3da-704f-f139f12752d8@linaro.org>
 <CAF6AEGta20EGJOvLcFWVfUa3kpfq+Udyp1QRNzjY8P290A2tVg@mail.gmail.com>
 <CAP71Wjy2gEn=sGz5kN++=TdZ4S1cmE-3fdw-5__tdtR-M9RDGQ@mail.gmail.com>
 <CAF6AEGvRB_SGQ_Xv33FiPZRyp+Wf29aG_Ex6rVk2Czov-Gjj9Q@mail.gmail.com>
 <CAF6AEGvtfAYx5mgg9mMVeXdO5mStD9gJvi5+Pp46jYj-e8WnOQ@mail.gmail.com>
 <CAAqcGH=aZSg7Dzv_Y2erUxmCaN7LXYqxgO9wnPKqSVX1fBuCMg@mail.gmail.com>
Message-ID: <3241c0f0-cc40-0262-a771-a0b6fd020b54@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 05.10.17 14:54, Riku Voipio wrote:
> On 5 October 2017 at 00:23, Rob Clark <robdclark@gmail.com> wrote:
>> On Tue, Oct 3, 2017 at 2:54 PM, Rob Clark <robdclark@gmail.com> wrote:
>>> On Tue, Oct 3, 2017 at 1:49 PM, Nicolas Dechesne
>>> <nicolas.dechesne@linaro.org> wrote:
>>>> On Tue, Oct 3, 2017 at 6:37 PM, Rob Clark <robdclark@gmail.com> wrote:
>>>>> On Tue, Oct 3, 2017 at 8:25 AM, Srinivas Kandagatla
>>>>> <srinivas.kandagatla@linaro.org> wrote:
>>>>>>
>>>>>>
>>>>>> On 03/10/17 10:11, Linus Walleij wrote:
>>>>>>>
>>>>>>> Naming the DragonBoard 410c "SBC" (I guess "single board computer")
>>>>>>> is not very helpful for users looking for their device tree in
>>>>>>> the kernel. Also the db820c is named properly.
>>>>>>>
>>>>>>> Rectify this, simply, do not change the compatible strings but name
>>>>>>> the DTS files in a consistent manner.
>>>>>>>
>>>>>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>>>>>
>>>>>> I did not like the sbc naming convention too, This was primarily done due to
>>>>>> some legacy build tools + bootloaders which have used sbc compatible to
>>>>>> identify boards from multiple dtb blobs. Now that we can append dtb to
>>>>>> kernel with new LK, this should not be a issue anymore.
>>>>>
>>>>> maybe it would be an idea to update skales/dbttool first to look for
>>>>> the new name, and then give people some time to upgrade, before
>>>>> changing this in the kernel.  Otherwise I expect you'll cause some
>>>>> confusion..
>>>>
>>>> iirc, skale is using the compatible name, not the filename.
>>>>
>>>
>>> ahh, yes, I think you are right.. u-boot is using a different filename.
>>>
>>> So in this case, no issue to pick a saner name :-)
>>>
>>
>> So, actually u-boot encodes the board's fdtname..  so as much as I'd
>> like to rename it to something more sane, unless the kernel can manage
>> to install a symlink for backwards compat, NAK
> 
> In some cases the partition where dtbs is FAT, which doesn't do
> symlinks. There are various instructions around that refer to editing
> apq8016-sbc.dts already[1]. The goal of the patch is to reduce
> confusion, but requiring different firmware depending on kernel
> version, and/or updated userspace, is actually going to increase the
> confusion and frustration. So I have echo Rob here.
> 
>> I was trying to think of hacks for u-boot to check for multiple fdt
>> names, but if we want to get to the point of being able to install
>> multiple distro's on a single disk, we actually need to pass fdtname
>> to grub (where distro specific grub.cfg is encoding the UUID of the
>> distro's /boot partition, so it knows where to load the dtb from)..
>> this gets nearly impossible when one name becomes multiple names.  So
>> hurray for the fdt name becoming accidental ABI!
> 
> It's unfortunate yes.
> 
> But is renaming .dts really needed to make finding the right DTS easier?
> 
> Maybe just pick this part the patch:
> 
> -       model = "Qualcomm Technologies, Inc. APQ 8016 SBC";
> +       model = "Qualcomm Technologies, Inc. APQ 8016 DragonBoard 410c";
> 
> then you can "git grep 410c " to find the file. This is how find the
> Nexus, Pixel and Jetson TX dts for example.

You could also simply carry around both, with for example the 
dragonboard one including sbc and overriding the machine name.

But please don't remove any device tree file names that were there 
before. It only causes confusion for everyone.


Alex
