From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Thu, 21 Dec 2017 11:53:27 +0100
Subject: [PATCH 0/3] Add DVFS support on CPU clock for Armada 37xx
In-Reply-To: <20171130134029.20751-1-gregory.clement@free-electrons.com>
 (Gregory CLEMENT's message of "Thu, 30 Nov 2017 14:40:26 +0100")
References: <20171130134029.20751-1-gregory.clement@free-electrons.com>
Message-ID: <87efnofj2w.fsf@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,
 
 On jeu., nov. 30 2017, Gregory CLEMENT <gregory.clement@free-electrons.com> wrote:

> Hi,
>
> This small series is needed to use DVFS on Armada 37xx. When DVFS is
> enabled the CPU clock setting is done using an other set of registers
> from the North Bridge Power Management block.
>
> The series adds the possibility to modify the CPU frequency using the
> associate load level matching the target frequency. However
> configuring the frequencies for each load is done by the cpufreq
> driver submitted in a separate series.
>
> Obviously having both series (cpufreq and clk) is needed to support
> DVFS on Armada 37xx, but there is no dependencies between the series
> (for building or at runtime).


I sent this series 3 weeks ago and I didn't have any feedback on
it. Does it mean that the series is OK for you and that you wait for a
PR for it?

Thanks,

Gregory



>
> Gregory CLEMENT (3):
>   clk: mvebu: armada-37xx-periph: cosmetic changes
>   clk: mvebu: armada-37xx-periph: prepare cpu clk to be used with DVFS
>   clk: mvebu: armada-37xx-periph: add DVFS support for cpu clocks
>
>  drivers/clk/mvebu/armada-37xx-periph.c | 310 +++++++++++++++++++++++++++++++--
>  1 file changed, 293 insertions(+), 17 deletions(-)
>
> -- 
> 2.15.0
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
