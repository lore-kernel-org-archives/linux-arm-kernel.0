From: robherring2@gmail.com (Rob Herring)
Date: Thu, 18 Oct 2012 15:52:09 -0500
Subject: [PATCHv1] arm:socfpga: Enable SMP for socfpga
In-Reply-To: <CADhT+wcJmwRMeNugWdgY+aU4EGE-y48R6OePTq==TjZajuxfeA@mail.gmail.com>
References: <1350501498-23601-1-git-send-email-dinguyen@altera.com>
 <507F01FD.6070403@gmail.com>
 <CADhT+wcJmwRMeNugWdgY+aU4EGE-y48R6OePTq==TjZajuxfeA@mail.gmail.com>
Message-ID: <50806BF9.9050103@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/17/2012 10:34 PM, Dinh Nguyen wrote:
> Hi Rob,
> 
> On Wed, Oct 17, 2012 at 2:07 PM, Rob Herring <robherring2@gmail.com> wrote:
>>
>> On 10/17/2012 02:18 PM, dinguyen at altera.com wrote:
>>> From: Dinh Nguyen <dinguyen@altera.com>
>>>
>>> Enable SMP for the SOCFPGA platform.
>>>
>>> Signed-off-by: Pavel Machek <pavel@denx.de>
>>> Signed-off-by: Dinh Nguyen <dinguyen@altera.com>
>>> ---
>>>  arch/arm/boot/dts/socfpga.dtsi            |   10 ++
>>>  arch/arm/configs/socfpga_defconfig        |    9 +-
>>
>> Does the multi_v7_defconfig not work for you?
> 
> It does. Are you planning to remove the defconfigs the platforms that
> are part of
> multi_v7_defconfig soon? socfpga_defconfig is broken with SMP enabled because
> it needs +# CONFIG_ARCH_VEXPRESS_CORTEX_A5_A9_ERRATA is not set.

I don't plan to remove them. I'll leave it up to the platform
maintainers as the new multi_v7 config is not exactly the same selections.

That's strange that you care about the errata setting. I think it should
work either way. We do need to scrub the errata list and enable all the
ones which have no runtime impact and are conditioned on the core
revision. I'm not sure what we'll do with the ones that could have a
negative impact on performance of rev's without an errata.

Rob
