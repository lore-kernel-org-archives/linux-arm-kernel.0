From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 6 Mar 2014 15:05:43 -0500
Subject: [PATCH 0/4] ARM: mvebu: Device Tree updates for Armada XP boards
In-Reply-To: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1393951022-18114-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20140306200543.GG1872@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 04, 2014 at 05:36:58PM +0100, Thomas Petazzoni wrote:
> Hello,
> 
> This set of commits updates the Armada XP DB and Armada XP GP Device
> Trees to work with the newest DT capable bootloaders from Marvell that
> remap internal registers at 0xf1000000 and move the MBus Window base
> address to 0xf0000000.
> 
> Also, the last commit updates the available amount of RAM on the
> Armada XP Matrix board.
> 
> Thomas
> 
> Thomas Petazzoni (4):
>   ARM: mvebu: change the default PCIe apertures for Armada 370/XP
>   ARM: mvebu: switch the Armada XP DB to use internal registers at
>     0xf1000000
>   ARM: mvebu: switch the Armada XP GP to use internal registers at
>     0xf1000000
>   ARM: mvebu: the Armada XP Matrix board has 4 GB
> 
>  arch/arm/boot/dts/armada-370-xp.dtsi   |  4 ++--
>  arch/arm/boot/dts/armada-xp-db.dts     | 13 +++++++++++--
>  arch/arm/boot/dts/armada-xp-gp.dts     | 22 ++++++++++++++++------
>  arch/arm/boot/dts/armada-xp-matrix.dts |  7 ++++++-
>  4 files changed, 35 insertions(+), 11 deletions(-)

Whole series applied to mvebu/dt.

fyi - we only have one more day of -next (tonight, 7pm US East Coast
time) before -rc6 drops.

I'm comfortable sending a lightly tested mvebu/dt pull request with all
the stuff submitted in the last couple days, but I fear there isn't
enough testing time before arm-soc stops taking pull requests.

I'm particularly concerned about the watchdog changes and the coherency
fabric changes.  I'll take those in when ready, and send pull requests
when appropriate, but that will most likely fall after the cutoff.
Which means those changes will carry over to v3.16...

thx,

Jason.
