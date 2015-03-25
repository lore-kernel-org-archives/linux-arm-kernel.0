From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 11:51:52 -0700
Subject: [PATCH v2 0/3] clk: sunxi: Add muxable AHB clock to fix hstimer
 issues
In-Reply-To: <1427217729-10017-1-git-send-email-wens@csie.org>
References: <1427217729-10017-1-git-send-email-wens@csie.org>
Message-ID: <20150325185152.GM23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 01:22:06AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is v2 of the sun5i muxable AHB clock series.
> 
> Changes since v1:
> 
>   - Dropped patches 1~3 that are merged
>   - Extend comments to clarify what the "base factor clock" refers to,
>     and what the divs clocks outputs should be.
> 
> 
> This series adds support for the muxable ahb clock on sun5/7i. The mux
> has inputs such as the axi clock, the cpu clock on sun5i, and pll6 with
> various dividers. The goal is to have ahb muxed to pll6, which should
> be a fixed rate albeit configurable clock. This fixes issues with
> cpufreq changing the cpu frequency, which would affect the hstimer
> clocked from ahb.
> 
> Patch 1 makes divs clocks explicitly specify in the driver which output
> is the base factor clock, instead of always putting it in last. This is
> done to ensure DT bindings compatibility when we add outputs.
> 
> Patch 2 adds the new pll6/4 output, which is used on sun7i as an input
> to ahb mux.
> 
> Patch 3 updates the dtsi files with the new drivers.
> 
> The series is also available at
> 
>     https://github.com/wens/linux/commits/sun5i-ahb-v2

Applied all three. I think it would be great to convert the later SoCs
to that too, just to make sure we have the same policy on all SoCs.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/55170eb9/attachment.sig>
