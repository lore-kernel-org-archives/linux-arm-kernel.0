From: csd@broadcom.com (Christian Daudt)
Date: Fri, 26 Jul 2013 16:55:39 -0700
Subject: [PATCH v2 1/5] ARM: Broadcom: Unconditionally build
 arch/arm/mach-bcm
In-Reply-To: <20130726232858.GA6953@glitch>
References: <20130726145639.116237136@gmail.com>
 <20130726151223.045835540@gmail.com>
 <20130726152918.GL29916@titan.lakedaemon.net>
 <20130726215859.GA19469@glitch>
 <20130726231108.GA10812@obsidianresearch.com>
 <20130726232858.GA6953@glitch>
Message-ID: <51F30C7B.6000504@broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13-07-26 04:28 PM, Domenico Andreoli wrote:
> On Fri, Jul 26, 2013 at 05:11:08PM -0600, Jason Gunthorpe wrote:
>> On Fri, Jul 26, 2013 at 11:59:00PM +0200, Domenico Andreoli wrote:
>>
>>> In mach-bcm we (or I, it's not very clear to me) want to have support for
>>> multiple SoCs.
>>>
>>> In trying the approach
>>>
>>> machine-$(CONFIG_ARCH_BCM)		+= bcm
>>> machine-$(CONFIG_ARCH_BCM4760)		+= bcm
>>>
>>> I got linker complains about multiple symbol definitiion in case both the
>>> config options are selected.
>> You can't repeat the same dir. Maybe this?
>>
>> bcm-machine-$(CONFIG_ARCH_BCM) := bmc
>> bcm-machine-$(CONFIG_ARCH_BCM4760) := bmc
>> machine-y += $(bcm-machine-y)
> nice! I prefer this to the config option used only to descend the dir,
> you never know how it is going to be abused.
>
> Christian, would you agree in ditching ARCH_BROADCOM then?
I'm fine with skipping ARCH_BROADCOM
  Thanks,
    csd
