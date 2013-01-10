From: hdoyu@nvidia.com (Hiroshi Doyu)
Date: Thu, 10 Jan 2013 16:03:00 +0100
Subject: [v2 5/9] clocksource: tegra: Enable ARM arch_timer with TSC
In-Reply-To: <79cf9366702f71f8c7add23b2aa0afec@localhost>
References: <20130109.075708.1662067562960541635.hdoyu@nvidia.com><50ED1F8F.4060700@ti.com><79cf9366702f71f8c7add23b2aa0afec@localhost>
Message-ID: <20130110.170300.1995294118512465281.hdoyu@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

Marc Zyngier <marc.zyngier@arm.com> wrote @ Wed, 9 Jan 2013 10:01:05 +0100:

> Almost. I already proposed this in the past, but because the source clock
> is variable in the Tegra case, this is not flexible enough.
> 
> What I was suggesting was to do the following:
> 
> timer {
>         compatible = "arm,armv7-timer";
>         [...]
>         clocks = <&tsc>;
> }
> 
> tsc: tsc {
>         compatible = "nvidia,tegra114-tsc";
>         reg = <0x700f0000 0x20000>;
>         freq-range = <... ...>;
>         clock-output-names = "tsc";
> }
> 
> In the arch_timer code, start searching for the "clocks" property, and use
> that if there is one. Otherwise, fall back to "clock-frequency", and
> ultimately to reading CNTFRQ.
> 
> This requires some changes (converting the tsc code to be a clock), but
> this is at least a proper description of the hardware, and should give you
> the required flexibility.

The above seems ok to me. I'll drop this original patch from this
series for now until T114 clock comes to implement correctly.
