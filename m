From: huangtao@rock-chips.com (Huang Tao)
Date: Fri, 29 Aug 2014 19:44:33 +0800
Subject: [RESEND PATCH] ARM: dts: make arch-timer always on in rk3288 soc
In-Reply-To: <20140829112242.GC21473@leverpostej>
References: <1409190017-12656-1-git-send-email-kever.yang@rock-chips.com>
 <20140828091758.GB14650@leverpostej> <20140828151121.GM14650@leverpostej>
 <53FFEE40.3010001@rock-chips.com> <20140829112242.GC21473@leverpostej>
Message-ID: <540067A1.6090005@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

? 2014?08?29? 19:22, Mark Rutland ??:
>> ? 2014?08?28? 23:11, Mark Rutland ??:
>>> To clarify: if there are low power states that the CPU can enter where
>>> we lose state, then this patch isn't correct.
>> Right now, the software of RK3288 SoC only support CPU hotplug
>> (cpu_on/off) and power off all CPUs on suspend.
> Sure, but that's a Linux implementation detail rather than a fixed
> property of the hardware. Given those states exist, the "always-on"
> property is not appropriate.
>
>> We do not implement cpuidle to power off CPU. Do you think we should
>> introduce a broadcast timer?
> If one is present, yes. 
>
>> On our early kernel, I never see any interrupt on a broadcast timer
>> (yes, we implement it with a external timer).
> That's fine; Linux doesn't need to use it just yet. However, when we
> want to use low power states later, it will be necessary to enable
> placing all CPUS into a low power state.
>
> If your external timer is already supported by an existing driver, there
> is no reason not to add it now.
>
>>> A more general approach would be to enable the broadcast hrtimer for
>>> arm, as has been done for arm64.
>> Yes. I think it should be done by arm framework.
> Patches welcome.
>
> I also think it would make sense to enable this for arm.
>
> Thanks,
> Mark.
>
>
Okay, so this patch is wrong as I expected.
Thank you!
