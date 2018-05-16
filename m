From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 16 May 2018 16:38:23 +0200
Subject: [RFC PATCH] driver core: make deferring probe forever optional
In-Reply-To: <45eca00d-57f5-21b5-1f6e-b5f3f60ad276@xilinx.com>
References: <20180501213114.20183-1-robh@kernel.org>
 <20180507183106.GF2259@tuxbook-pro>
 <91dad272-e07d-2ab6-2afa-538294e9cefa@suse.de>
 <CACRpkdaYN-wKErERP_65T2NH6L-+8O_ugSgg7pXfkaLkn1A2KQ@mail.gmail.com>
 <c6655f84-747f-c08b-7b9c-f76ff8857567@suse.de>
 <45eca00d-57f5-21b5-1f6e-b5f3f60ad276@xilinx.com>
Message-ID: <CACRpkdYijOTMDr6Omh8pt2T2ugExpWngqp+bydBJG2tiyE2k7Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2018 at 2:44 PM, Michal Simek <michal.simek@xilinx.com> wrote:
> On 14.5.2018 09:37, Alexander Graf wrote:
>> On 05/14/2018 12:01 AM, Linus Walleij wrote:
>>> On Wed, May 9, 2018 at 11:44 AM, Alexander Graf <agraf@suse.de> wrote:
>>>> On 05/07/2018 08:31 PM, Bjorn Andersson wrote:
>>>>> Can you please name platform that has enough support for Alexander to
>>>>> care about backwards and forwards compatibility but lacks a pinctrl
>>>>> driver.
>>>> ZynqMP is one example that immediately comes to my mind. I'm sure
>>>> there are
>>>> others too.
>>> Why isn't that using drivers/pinctrl/pinctrl-zynq.c?
>>>
>>> How is it so very different from (old) Zynq as it is already using
>>> the same GPIO driver?
>>
>> That one is very simple: ZynqMP is usually an AMP system where Linux
>> doesn't have full knowledge of the overall system. IIUC they have a tiny
>> microblaze (PMU) that does the actual full system configuration for
>> peripherals that may interfere with each other. This architecture also
>> allows for safety critical code to run alongside a (less safe) Linux
>> system.
>
> Linux is running in non secure world that's why Linux can't have full
> system visibility and Linux should ask firmware. It doesn't matter if
> firmware is running on specific unit or just secure SW in EL3/EL1-S, EL0-S.
> You can also configure ZynqMP to protect these address ranges not to be
> accessible from NS sw.
> If you don't care about security you can use normal read/write accesses
> at least for gpio case. Pinctrl/clk will be driven via firmware interface.

OK I get it, the situation is similar to some ACPI-based BIOSes on
PC where one needs to ask the firmware for misc services.

What would be nice is to standardize these APIs (like ACPI or device
tree does) so we don't end up with one per-SoC-specific driver per
system. But I guess it is not my pick.

Yours,
Linus Walleij
