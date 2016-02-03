From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 3 Feb 2016 21:43:31 +0530
Subject: Plain DFS (no voltage scaling)
In-Reply-To: <56B217C9.1050405@free.fr>
References: <56B11B67.3090600@free.fr>
 <56B217C9.1050405@free.fr>
Message-ID: <20160203161331.GI3469@vireshk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03-02-16, 16:07, Mason wrote:
> On 02/02/2016 22:11, Mason wrote:
> 
> > I plan to enable the on-demand governor on the tango platform:
> > https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/arch/arm/boot/dts/tango4-smp8758.dtsi
> > 
> > I found the cpufreq-dt binding doc:
> > 
> > https://www.kernel.org/doc/Documentation/devicetree/bindings/cpufreq/cpufreq-dt.txt
> > https://www.kernel.org/doc/Documentation/devicetree/bindings/opp/opp.txt
> > 
> > Something is not clear to me:
> > 
> > If my platform cannot scale the voltage, what information
> > should I put in the voltage part of the DT?
> 
> Someone pointed out that tweaking the frequency without tweaking
> the voltage might be counter-productive.
> 
> I measured the power consumption of the entire board (at the power outlet)
> for 3 CPU frequencies (all other things being equal, I hope).
> 
> idle @ 111 MHz = 4.6 W
> idle @ 333 MHz = 4.6 W
> idle @ 999 MHz = 4.6 W
> 
> load @ 111 MHz = 5.0 W
> load @ 333 MHz = 5.7 W
> load @ 999 MHz = 7.7 W
> 
> When idle, the kernel calls WFI, which "turns off" most of the CPU
> (clock gating?) such that the actual frequency does not matter.
> 
> At full load (I use cpuburn to jog as many FUs simultaneously as
> possible) it looks like each additional MHz requires ~3 mW.
> 
> So it would appear that an on-demand governor might not help to
> save power.

Why do you say so ?

> But I have another use-case in mind: CPU throttling on over-heating.
> There's a temperature sensor in the CPU, and I'd like to say:
> "if temperature exceeds a user-set threshold, don't run at the max
> frequency until the temperature becomes reasonable".
> 
> And I think that requires cpufreq?
> 
> Regards.

-- 
viresh
