From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 11 May 2012 11:31:47 -0500
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <20120511150223.GD2626@mudshark.cambridge.arm.com>
References: <4FAA4DB9.8060504@ti.com> <4FAAB1A3.9040806@ti.com>
 <4FAAC549.6010206@ti.com> <4FAAE564.6040708@ti.com>
 <20120510084422.GB27276@mudshark.cambridge.arm.com> <4FAC0F05.3060803@ti.com>
 <20120511122547.GE17453@mudshark.cambridge.arm.com> <4FAD1865.70003@ti.com>
 <20120511134920.GC2626@mudshark.cambridge.arm.com> <4FAD27CB.5060102@ti.com>
 <20120511150223.GD2626@mudshark.cambridge.arm.com>
Message-ID: <4FAD3EF3.4080409@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Will,

On 05/11/2012 10:02 AM, Will Deacon wrote:
> On Fri, May 11, 2012 at 03:52:59PM +0100, Jon Hunter wrote:
>> Hi Will,
> 
> Hello,
> 
>> On 05/11/2012 08:49 AM, Will Deacon wrote:
>>> I enabled OMAP3 debug peripherals, so I selected CPU_HAS_PMU that way.
>>
>> I tried the same (make omap2plus_defconfig and enabled the above
>> option), and I do see the interrupts firing on both 4430 and 4460...
>>
>> / # cat /proc/interrupts
>>            CPU0       CPU1
>>  29:       1023        404       GIC  twd
>>  33:        401          0       GIC  arm-pmu
>>  34:          0        441       GIC  arm-pmu
> 
> Well, at least it's working for somebody!
> 
>> What is your kernel commit ID that you applied the patches on top of?
> 
> 7cf543bc ("Linux-omap rebuilt: Updated to -rc6, merged in pending branches,
> please test"). Is there something else I need too?

Ok, thanks. I was based upon Tony's -rc5. However, I rebased to the same
as you and it is still working for me

Can you send me your .config?

At the same time, maybe just try "make omap2plus_defconfig" and enable
the OMAP3 debug devices config. That's all I am doing.

>> What board are you using? Blaze, panda, etc, and is it 4430 or 4460?
> 
> Ye olde Panda 4430. It does work with my perf/omap4 branch though using the
> same .config (I can mail it to you separately if you want).

Ok, should be fine. The kernel should print the ES version on start-up ...

[    0.000000] OMAP4430 ES2.2

What does yours show?

Cheers
Jon
