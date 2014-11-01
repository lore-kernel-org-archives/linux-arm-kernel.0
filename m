From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sat, 01 Nov 2014 16:43:40 +0100
Subject: [PATCH v2 3/3] ARM: dts: qcom: Add SDHC nodes for APQ8084 platform
In-Reply-To: <543D4C87.9050703@mm-sol.com>
References: <1409672443-4289-1-git-send-email-gdjakov@mm-sol.com>	<1409672443-4289-4-git-send-email-gdjakov@mm-sol.com>
 <CAJAp7OhV82HyDQSRW4F2z6UD6WZzuopBoUZMeT2pYBdGq-Dqcg@mail.gmail.com>
 <543D4C87.9050703@mm-sol.com>
Message-ID: <5454FFAC.2040500@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Georgi,

Am 14.10.2014 um 18:17 schrieb Georgi Djakov:
> On 10/10/2014 08:14 PM, Bjorn Andersson wrote:
>> On Tue, Sep 2, 2014 at 8:40 AM, Georgi Djakov <gdjakov@mm-sol.com> wrote:
>>> Enable support for the two SD host controllers on the APQ8084 platform
>>> by adding the required nodes to the DT files.
>>> On the IFC6540 board, the first controller is connected to the onboard
>>> eMMC and the second is connected to a micro-SD card slot.
>>>
>>> Signed-off-by: Georgi Djakov <gdjakov@mm-sol.com>
[...]
>>> ---
>>>  arch/arm/boot/dts/qcom-apq8084-ifc6540.dts |   11 +++++++++++
>>>  arch/arm/boot/dts/qcom-apq8084.dtsi        |   23 +++++++++++++++++++++++
>>>  2 files changed, 34 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
>>> index e41cb8a..c9ff108 100644
>>> --- a/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
>>> +++ b/arch/arm/boot/dts/qcom-apq8084-ifc6540.dts
>> [..]
>>> +               sdhci at f98a4900 {
>>> +                       cd-gpios = <&tlmm 122 GPIO_ACTIVE_LOW>;
>>> +                       bus-width = <4>;
>>
>> ...why do you add this node and leave it disabled in the dts?
>>
> 
> Hi Bjorn,
> Currently only the eMMC is functional on this board, so now we
> have just the board specific configuration under this node.
> More patches are forthcoming.

Any update on this? This still seems to be the latest IFC6540 commit:

https://git.linaro.org/landing-teams/working/qualcomm/kernel.git/commit/66c04e30f4a6e6ed998a6c154a6c45b3cd5b3fde

Following the instructions in https://wiki.linaro.org/Boards/IFC6540
I've tried to pass a full rootfs as ramdisk parameter (fastboot boot -c
"console=ttyMSM0,115200,n8 rw rootwait" -b 0x0 zImage-ifc6540
initrd.cpio.gz), but I then get:

[258660] fastboot: download:12738800
[268150] fastboot: boot
[268150] kernel/ramdisk addresses overlap with aboot addresses.

Booting without ramdisk specified works, but for lack of SD, USB and
network support I then have no root.

So, do you have any new insights on why 'status = "okay";' doesn't work
for the above sdhci node? Or do you have a working config you can share
for creating a non-overlapping abootimg?

Regards,
Andreas

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
