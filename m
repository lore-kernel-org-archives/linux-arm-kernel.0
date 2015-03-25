From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Mar 2015 15:07:46 -0700
Subject: [PATCH 0/3] ARM: dts: sun6i: Enable cpufreq support for A31/A31s
In-Reply-To: <1427317489-708-1-git-send-email-wens@csie.org>
References: <1427317489-708-1-git-send-email-wens@csie.org>
Message-ID: <20150325220746.GQ23664@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 26, 2015 at 05:04:46AM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This series adds the DT parts of cpufreq support, clock references, thermal
> zones and OPPs, for sun6i. This is based on sunxi/for-next (6bcf44d5edfb).
> Required (sun4i-ts) driver support is already in v4.0-rc1.
> 
> Patch 1 moves the ahb1 assigned-clocks reparenting properties from the dma
> controller node to the ahb1 clock node. This matches what we've done for
> sun5i and sun7i. The purpose of this is to clock ahb1 from a stable clock
> as soon as possible, to prevent hrtimer miscalculation/instability.
> 
> Patch 2 adds the clock reference and OPPs for the cpu cluster.
> 
> Patch 3 adds the thermal zones for CPU passive (cpufreq limiting) cooling.
> 
> I've tested this on my Sinlinx SinA31s (not yet mainlined). The highest
> OPP matches the default CPU clock/voltage setting found in mainline
> u-boot. However the Mele I7 fex file specifies a slightly higher voltage
> for 1008 MHz. If the default setting is not stable enough for the Mele
> I7, it should be overridden in the board dts file.
> 
> This series does not cover A31/A31s revision D, which seems to have lower
> voltage requirements. At the moment no one has seen them.

Applied all three, thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150325/e3de4ba7/attachment.sig>
