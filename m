From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 5 Mar 2015 17:04:50 +0000
Subject: [PATCH v5 1/9] arm64: dts: exynos: Add dts files for 64-bit
 Exynos5433 SoC
In-Reply-To: <CAGTfZH3Bf1ueFO25NXFbN+Mvb9TcGbErbSp=a+vQ0=A+E07mQA@mail.gmail.com>
References: <1425533911-14800-1-git-send-email-cw00.choi@samsung.com>
 <1425533911-14800-2-git-send-email-cw00.choi@samsung.com>
 <20150305122459.GC14093@leverpostej>
 <CAGTfZH3Bf1ueFO25NXFbN+Mvb9TcGbErbSp=a+vQ0=A+E07mQA@mail.gmail.com>
Message-ID: <20150305170450.GG14093@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[...]

> >> +       psci {
> >> +               compatible = "arm,psci";
> >> +               method = "smc";
> >> +               cpu_off = <0x84000002>;
> >> +               cpu_on = <0xC4000003>;
> >> +       };
> >
> > Back at v2 you mentioned that CPU_OFF wasn't working [1].
> >
> > Do both CPU_ON and CPU_OFF work for all CPUs, including the boot CPU?
> 
> The CPU1 ~ CPU7 are well woking about CPU_ON/OFF.
> CPU0 (boot CPU) is only well working for CPU_OFF.
> But when I try to turn on the CPU0 after CPU_OFF, I failed it.

That's rather worrying. Can you look into what's going on here? I'd
rather not have dts describing things which are known to be broken.

> > I take it CPUs boot at EL2?

Do the CPUs boot at EL1 or EL2?

[...]

> > The timer node should be moved under the root node. It doesn't live on
> > the bus; it's a component of the CPU.
> 
> OK. I'll move it according to your comment.

Thanks.

Mark.
