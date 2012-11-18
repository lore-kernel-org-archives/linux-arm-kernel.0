From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 18 Nov 2012 20:52:35 +0100
Subject: [GIT PULL] arm: orion5x: begin the DT conversion
In-Reply-To: <1353080388-4091-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1353080388-4091-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20121118195235.GJ11717@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 16, 2012 at 04:39:43PM +0100, Thomas Petazzoni wrote:
> Jason, Andrew,
> 
> Here is a set of four patches that start the conversion of
> mach-orion5x to the Device Tree. It for now converts only one board,
> which has been tested by Maxime Hadjinlian from LaCie (thanks a lot!),
> but we intend to do more in the future (Maxime will get another
> Orion5x platform, and I have received another one this week). I have
> also started working on a pinctrl driver for the Orion5x platforms.
> 
> I've put the four patches in the same branch: 2/4 is SoC related and
> 3/4 board related, but 3/4 cannot live without 2/4. If you'd like to
> have this series split in several pull requests, do not hesitate to
> let me know how the split should be done.

Hi Thomas

I looked over the patches, compile tested them. Looks good to me.

Acked-by: Andrew Lunn <andrew@lunn.ch>

	  Andrew

> 
> Thanks,
> 
> Thomas
> 
> The following changes since commit 77b67063bb6bce6d475e910d3b886a606d0d91f7:
> 
>   Linux 3.7-rc5 (2012-11-11 13:44:33 +0100)
> 
> are available in the git repository at:
> 
>   git at github.com:MISL-EBU-System-SW/mainline-public.git tags/marvell-orion-dt-3.8
> 
> for you to fetch changes up to 559b1d157fddc02a68ea045df2a0c40cb713e292:
> 
>   arm: orion5x: add DT related options in defconfig (2012-11-16 16:22:07 +0100)
> 
> ----------------------------------------------------------------
> Marvell Orion DT conversion for 3.8
> 
> ----------------------------------------------------------------
> Thomas Petazzoni (4):
>       arm: orion5x: mechanical defconfig update
>       arm: orion5x: basic Device Tree support
>       arm: orion5x: convert 'LaCie Ethernet Disk mini v2' to Device Tree
>       arm: orion5x: add DT related options in defconfig
> 
>  arch/arm/boot/dts/Makefile                         |    1 +
>  .../dts/orion5x-lacie-ethernet-disk-mini-v2.dts    |   55 +++++++++++
>  arch/arm/boot/dts/orion5x.dtsi                     |   98 ++++++++++++++++++++
>  arch/arm/configs/orion5x_defconfig                 |   36 +++----
>  arch/arm/mach-orion5x/Kconfig                      |   14 ++-
>  arch/arm/mach-orion5x/Makefile                     |    4 +-
>  arch/arm/mach-orion5x/board-dt.c                   |   79 ++++++++++++++++
>  arch/arm/mach-orion5x/common.c                     |    4 +-
>  arch/arm/mach-orion5x/common.h                     |    9 ++
>  arch/arm/mach-orion5x/edmini_v2-setup.c            |   88 +-----------------
>  10 files changed, 270 insertions(+), 118 deletions(-)
>  create mode 100644 arch/arm/boot/dts/orion5x-lacie-ethernet-disk-mini-v2.dts
>  create mode 100644 arch/arm/boot/dts/orion5x.dtsi
>  create mode 100644 arch/arm/mach-orion5x/board-dt.c
> 
