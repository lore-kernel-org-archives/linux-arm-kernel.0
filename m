From: robh@kernel.org (Rob Herring)
Date: Mon, 15 Jan 2018 11:21:24 -0600
Subject: [PATCH 5/6] arm64: tegra: Add Tegra194 chip device tree
In-Reply-To: <7085e085-134c-27cf-6ee7-ae691e63d454@kapsi.fi>
References: <1515387278-29777-1-git-send-email-mperttunen@nvidia.com>
 <1515387278-29777-6-git-send-email-mperttunen@nvidia.com>
 <20180111215638.f5vxykb2vvxeypmk@rob-hp-laptop>
 <7085e085-134c-27cf-6ee7-ae691e63d454@kapsi.fi>
Message-ID: <CAL_JsqLH8FJ+ppFrtxS7ja-Apkj=RfDcDoFOtNPsnbb6+Pgp-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 12, 2018 at 1:22 AM, Mikko Perttunen <cyndis@kapsi.fi> wrote:
> On 11.01.2018 23:56, Rob Herring wrote:
>>
>> On Mon, Jan 08, 2018 at 06:54:37AM +0200, Mikko Perttunen wrote:
>>>
>>> Add the chip-level device tree, including binding headers, for the
>>> NVIDIA Tegra194 "Xavier" system-on-chip. Only a small subset of devices
>>> are initially available, enough to boot to UART console.
>>>
>>> Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
>>> ---

>>> +       interrupt-parent = <&gic>;
>>> +       #address-cells = <2>;
>>> +       #size-cells = <2>;
>>> +
>>> +       uarta: serial at 3100000 {
>>
>>
>> These should all be under a bus node. Tegra failed to do this at the
>> start and we're still copy-n-pasting this mistake.
>>
>> Then you probably don't need 2 address and size cells for all the
>> peripherals.
>
>
> So I should create one big simple-bus node and put everything with an
> address apart from /memory (and maybe /sysram) inside it?

Yes. Though you can have multiple buses if that makes sense. Things
like fixed clocks, gpio-leds, etc. (typically board level) that don't
have any bus should stay at the top level.

Rob
