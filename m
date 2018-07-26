From: olof@lixom.net (Olof Johansson)
Date: Thu, 26 Jul 2018 00:02:01 -0700
Subject: [GIT PULL v2] Renesas ARM Based SoC Defconfig Updates for v4.19
In-Reply-To: <cover.1532346690.git.horms+renesas@verge.net.au>
References: <cover.1532346690.git.horms+renesas@verge.net.au>
Message-ID: <20180726070201.daqqzochaxkgktev@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 23, 2018 at 02:04:13PM +0200, Simon Horman wrote:
> Hi Olof, Hi Kevin, Hi Arnd,
> 
> Please consider these Renesas ARM based SoC defconfig updates for v4.19.
> 
> Changes since v1:
> * Dropped patch to set CONFIG_LOCALVERSION as requested by Olof
> * Dropped patch to Enable MTD command line partition parsing as
>   Olof has asked for more discussion on the related DTS change
> 
> 
> The following changes since commit ce397d215ccd07b8ae3f71db689aedb85d56ab40:
> 
>   Linux 4.18-rc1 (2018-06-17 08:04:49 +0900)
> 
> are available in the git repository at:
> 
>   https://git.kernel.org/pub/scm/linux/kernel/git/horms/renesas.git tags/renesas-arm-defconfig-for-v4.19
> 
> for you to fetch changes up to b036e6420b9aed3498cbd0429f12300139cc5a28:
> 
>   ARM: multi_v7_defconfig: Enable support for RZN1D-DB (2018-07-23 13:48:02 +0200)
> 
> ----------------------------------------------------------------
> Renesas ARM Based SoC Defconfig Updates for v4.19
> 
> multi_v7_defconfig and shmobile_defconfig Enhancement:
> 
> * Enable support for recently upstreamed RZN1D-DB board
>   in multi_v7_defconfig and shmobile_defconfig. This is
>   to give better test coverage.
> 
> shmobile_defconfig Clean-Up:
> 
> * Drop NET_VENDOR_<FOO>=n
> 
>   This reduces the size of the defconfig without any change in the
>   resulting kernel config.
> 
> shmobile_defconfig Enhancements:
> 
> * Disable long deprecated /sbin/hotplug helper
> 
> * Enable reset controller support
> 
>   This is to give better test coverage.
>   This may be used by reset controller support in the Renesas CPG/MSSR
>   driver when used by R-Car Gen2 and RZ/G1 SoCs.

Merged with this commit message:

 - Enable new RZN1D-DB board in multi_v7_defconfig and shmobile_defconfig

 - shmobile_defconfig:
   + Drop NET_VENDOR_<FOO>=n
   + Disable long deprecated /sbin/hotplug helper
   + Enable reset controller support



Thanks,

-Olof
