From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 13 Aug 2014 11:12:01 -0600
Subject: [PATCH 1/2] ARM: tegra: add Acer Chromebook 13 device tree
In-Reply-To: <CAL1qeaGxcp4okVTYCMj0zMh-4HzsGLBvngv0+A1m8o3sZPDj2A@mail.gmail.com>
References: <1407894967-18300-1-git-send-email-dgreid@chromium.org>	<20140813085304.GE7735@ulmo>	<53EB9786.6010809@wwwdotorg.org>
 <CAL1qeaGxcp4okVTYCMj0zMh-4HzsGLBvngv0+A1m8o3sZPDj2A@mail.gmail.com>
Message-ID: <53EB9C61.1070406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 11:04 AM, Andrew Bresticker wrote:
> On Wed, Aug 13, 2014 at 9:51 AM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 08/13/2014 02:53 AM, Thierry Reding wrote:
>>>
>>> On Tue, Aug 12, 2014 at 06:56:07PM -0700, Dylan Reid wrote:
>>>>
>>>> The Acer Chromebook 13, codenamed "Big", contains an NVIDIA tegra124
>>>> processor and is similar to the Venice2 reference platform.
>>>>
>>>> The keyboard, USB 2, audio, HDMI, sdcard and emmc have been tested
>>>> and work on the 1366x768 models.  I haven't tried on the HD systems
>>>> yet.
>>>
>>>
>>> Presumably the HD systems will have a different compatible? Is it only
>>> the panel that's different or are there other changes?
>>
>>
>> Yes, we definitely need to plan ahead for the different SKUs. I assume we'll
>> have different board names for each board, which then translates int DT
>> filenames and U-Boot/cbootimage-configs/tegra-uboot-flasher board
>
> The firmware does not differentiate between the HD and non-HD boards,
> so it will look for the same compatible string.  As I mentioned in my
> response to Thierry, we'd need to parse the EDID to figure out which
> panel is being used.

Well, that's if we do it at run-time. We could just have a separate DT 
per SKU, couldn't we?
