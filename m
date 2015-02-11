From: wangbintian@gmail.com (Brent Wang)
Date: Wed, 11 Feb 2015 09:49:26 +0800
Subject: [PATCH 3/3] arm64: dts: Add dts files for Hisilicon Hi6220 SoC
In-Reply-To: <20150210152718.GE9432@leverpostej>
References: <1423128277-10297-1-git-send-email-bintian.wang@huawei.com>
 <1423128277-10297-4-git-send-email-bintian.wang@huawei.com>
 <20150205193017.GF20735@leverpostej>
 <CAAS=xmgsuY=c8-n_pDiZjLe2u+SPX7msRje7h0sNkRtT3HLfQA@mail.gmail.com>
 <20150206104420.GB9921@leverpostej>
 <CAAS=xmhcfeQjfyizJa38k+08pbY5WFOZH0a1wEx+gwqgVe0MXw@mail.gmail.com>
 <20150210133734.GC9432@leverpostej>
 <CAAS=xmgvQLSOXGHmDhFKKV+UGLGeZXf2dpOYWzALYTRsYp9D7g@mail.gmail.com>
 <20150210152718.GE9432@leverpostej>
Message-ID: <CAAS=xmhGiiDWm+c-dbX7NTECgLW9iCrtaUFLzwzriqV9Tpktrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mark,

2015-02-10 23:27 GMT+08:00 Mark Rutland <mark.rutland@arm.com>:
 [...]
>> >
>> >> >> >> +             pm_ctrl: pm_ctrl {
>> >> >> >> +                     compatible = "hisilicon,pmctrl", "syscon";
>> >> >> >> +                     #address-cells = <1>;
>> >> >> >> +                     #size-cells = <1>;
>> >> >> >> +                     reg = <0x0 0xf7032000 0x0 0x1000>;
>> >> >> >> +                     ranges = <0 0x0 0xf7032000 0x1000>;
>> >> >> >> +
>> >> >> >> +                     clock_power: clock3 at 0 {
>> >> >> >> +                             compatible = "hisilicon,hi6220-clock-power";
>> >> >> >> +                             reg = <0 0x1000>;
>> >> >> >> +                             #clock-cells = <1>;
>> >> >> >> +                     };
>> >> >> >> +             };
>> >> >> >
>> >> >> > I really doesn't see the point in having a sub-device that covers the
>> >> >> > entirely of the register space of the containing node, and that being
>> >> >> > the case I am extremely concerned that the containers are marked as
>> >> >> > syscon compatible.
>> >> >> The SoC clocks are designed and placed under different system controllers,
>> >> >> so I define corresponding nodes under different controllers for clock operation.
>> >> >
>> >> > What I'm concerned wit hhere is that the pm_ctrl node and the clock3 at 0
>> >> > sub-node have the _exact_ same register space.
>> >> >
>> >> > Given this should mean that the clock3 at 0 node owns that register space,
>> >> > having the container node export this as syscon does not make sense. And
>> >> > the split between pm_ctrl and clock3@) doesn't seem to make sense given
>> >> > they cover the same space.
>> >> I understand your worry and will find the max offset of those clocks
>> >> under this controller.
>> >>
>> >> >
>> >> > As I asked before, why is pm_ctrl marked as a syscon, and what's the
>> >> > point of the separate sub-node?
>> >> There is no big difference between pm_ctrl and other controller,  they
>> >> are all designed as
>> >> the base address to control some functions of other modules (certainly
>> >> include some clock gates).
>> >
>> > Are they just different instances of the same IP block, or are there
>> > fundamental differences between them?
>> You can understand it as a different instance of the same IP block,
>> there is no fundamental
>> differences between them.
>
> Ok. If that's the case each should have the same compatible string.
Although they have same function, they control different domain, I
should use different compatible string to distinguish different
domains.

Thanks,

Bintian
>
> Thanks,
> Mark.



-- 
Best Regards,

Bintian
===========================
Don't be nervous, just be happy!
