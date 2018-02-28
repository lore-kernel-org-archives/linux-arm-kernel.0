From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 28 Feb 2018 15:40:13 +0100
Subject: [PATCH 0/3] add CPUs OPPs to sun8i a83t
In-Reply-To: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
References: <cover.f1ec43f8d2a0151c52434f0952e973b19626f285.1519823347.git-series.quentin.schulz@bootlin.com>
Message-ID: <20180228144013.ayd65zbezdya7cbo@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 28, 2018 at 02:11:19PM +0100, Quentin Schulz wrote:
> Hi all,
> 
> The Allwinner A83T is an octacore A7 divided in two clusters of 4 A7,
> each cluster having its own regulator and clock.
> 
> Let's add the OPPs for each cluster so that we can use cpufreq on this SoC.
> 
> The operating points were found in Allwinner BSP and fex files and have
> been tested on a TBS A711 with cpuburn and cpufreq-ljt-stress-test.
> 
> Note that there are a few OPPs that are missing:
> 
> 1608000000Hz with 920000mV
> 1800000000Hz with 1000000mV
> 2016000000Hz with 1080000mV
> 
> These OPPs are pretty unstable but it might be due to the SoC quickly
> overheating (till the board completely shuts down).
> It seems[1] impossible to reach those frequencies with none or passive
> cooling, so better leave them out by default.
> 
> It's still possible to add those OPPs on a per-board basis though.
> 
> [1] http://linux-sunxi.org/User:Tkaiser#First_steps_with_Banana_Pi_M3

Applied all three. The patch 3/3 wasn't ordered properly, so I fixed
it, and I removed the newline pointed out by Thomas.

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180228/9f243e83/attachment.sig>
