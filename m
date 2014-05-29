From: mturquette@linaro.org (Mike Turquette)
Date: Thu, 29 May 2014 09:30:47 -0700
Subject: [PATCH v2 00/10] Marvell Berlin full clock support
In-Reply-To: <5386FBC3.1000003@gmail.com>
References: <1400517811-24668-1-git-send-email-sebastian.hesselbarth@gmail.com>
 <20140529000713.10062.99196@quantum> <5386FBC3.1000003@gmail.com>
Message-ID: <20140529163047.10062.93368@quantum>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Sebastian Hesselbarth (2014-05-29 02:20:03)
> On 05/29/2014 02:07 AM, Mike Turquette wrote:
> > Quoting Sebastian Hesselbarth (2014-05-19 09:43:21)
> >> Mike,
> >>
> >> this is v2 of the Berlin SoC clock driver [1] but with a reworked DT
> >> binding as requested [2]. We decided to not even try to split up the chip
> >> control registers that deal with pinmux, padmux, clock, reset, and evil
> >> stuff we haven't even looked at. Instead we keep a single node that clock
> >> driver will remap early, while proper platform_drivers use a regmap
> >> instead. Although clock and other drivers share the same register range,
> >> they use individual registers exclusively.
> >>
> >> There are some functional fixes in the single clock drivers, I noticed
> >> while retesting each individial driver. There will be more to fixup but
> >> without any drivers actually using the clocks, it is hard to tell what
> >> isn't working now.
> >>
> >> Anyway, the current binding should match what you requested and having
> >> a clock driver for v3.16 will really be a huge benefit for us to work
> >> on more driver support.
> >>
> >> If you are fine with it, please take patches 2-7 and I'll pick up
> >> 1,8-10 in berlin branch.
> > 
> > Patches #2-7 applied to clk-next.
> 
> Thanks Mike, but please drop patch #2
>   ("clk: berlin: add binding include for Berlin SoC clock ids")
> before you push your clk-next branch, it already went through arm-soc.

Thanks for the heads-up. I've dropped the patch.

Regards,
Mike

> 
> Sorry,
>   Sebastian
