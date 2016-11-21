From: david@lechnology.com (David Lechner)
Date: Mon, 21 Nov 2016 11:45:14 -0600
Subject: [PATCH 0/2] ARM: davinvi: da850 add ohci DT nodes
In-Reply-To: <CAKXjFTPxwxtE1xs1b6+sfwvRNKVLGKM-9Fjs3tVOSaBA+5Wnxg@mail.gmail.com>
References: <20161121165920.29809-1-ahaslam@baylibre.com>
 <4d414c4d-3d08-f3d9-2bc5-aa90c8a631ce@lechnology.com>
 <CAKXjFTPxwxtE1xs1b6+sfwvRNKVLGKM-9Fjs3tVOSaBA+5Wnxg@mail.gmail.com>
Message-ID: <4095b7bc-a6dd-144b-4a65-40d86c710087@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/21/2016 11:29 AM, Axel Haslam wrote:
> On Mon, Nov 21, 2016 at 6:04 PM, David Lechner <david@lechnology.com> wrote:
>> On 11/21/2016 10:59 AM, Axel Haslam wrote:
>>>
>>> This adds the DT node for the ohci controller and
>>> enables it for the omapl138-lckd platform.
>>>
>>> DEPENDENCIES:
>>>
>>> 1. [PATCH v6 0/5] USB: ohci-da8xx: Add device tree support
>>> https://lkml.org/lkml/2016/11/21/558
>>>
>>> 2. [PATCH v3 0/2] regulator: handling of error conditions for usb drivers
>>> https://lkml.org/lkml/2016/11/4/465
>>>
>>> Axel Haslam (2):
>>>   ARM: dts: da850: Add usb device node
>>>   ARM: dts: da850-lcdk: Enable ohci for omapl138 lcdk
>>>
>>>  arch/arm/boot/dts/da850-lcdk.dts | 8 ++++++++
>>>  arch/arm/boot/dts/da850.dtsi     | 8 ++++++++
>>>  2 files changed, 16 insertions(+)
>>>
>>
>> It does not look like you rebased these patches. Sekhar pushed the musb
>> counterpart to v4.10/dt yesterday, which will cause conflicts with this
>> series.
>>
>> https://git.kernel.org/cgit/linux/kernel/git/nsekhar/linux-davinci.git/log/?h=v4.10/dt
>
> Hi David,
>
> i verified that they apply to the current linux-davinci/master.
> Anyways, i can rebase
> and resend once the dependencies are met, and we are ready to merge it.
>
> Regards
> Axel.
>

OK. I think the first patch is fine, but you will have two &usb_phy {
status = "okay"; }; in da850-lcdk.dts now even if applies cleanly. ;-)
