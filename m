From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 12 May 2011 13:26:32 -0700
Subject: [GIT PULL 1/3] ARM: tegra: trimslice: register i2c busses and
	devices
In-Reply-To: <afc96d35d332d0293dfb5baf3e1b53045627f6a1.1305105580.git.mike@compulab.co.il>
References: <cover.1305105580.git.mike@compulab.co.il>
	<afc96d35d332d0293dfb5baf3e1b53045627f6a1.1305105580.git.mike@compulab.co.il>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04986AA405@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Mike Rapoport wrote at Wednesday, May 11, 2011 5:08 AM:
> Signed-off-by: Mike Rapoport <mike@compulab.co.il>
> ---
>  arch/arm/mach-tegra/board-trimslice.c |   39 +++++++++++++++++++++++++++++++++
>  1 files changed, 39 insertions(+), 0 deletions(-)

I think you also need the following change to board-trimslice-pinmux.c:

-	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_OSC,           TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},
+	{TEGRA_PINGROUP_CDEV1, TEGRA_MUX_PLLA_OUT,      TEGRA_PUPD_NORMAL,      TEGRA_TRI_NORMAL},

Assuming that the CDEV1 clock output from Tegra is used as the codec's
master clock.

-- 
nvpublic
