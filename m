From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 03 Mar 2011 13:43:02 +0900
Subject: [PATCH/RFC 0/3] ARM: S5P: Add common DPHY control code for
	MIPI-CSIS/MIPI-DSIM devices
In-Reply-To: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
References: <1299087289-29926-1-git-send-email-s.nawrocki@samsung.com>
Message-ID: <01a701cbd95d$9873c160$c95b4420$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sylwester Nawrocki wrote:
> 
> Hello,
> 
> the following patch series adds a common platform code to enable control
> of MIPI-CSI receiver's DPHY from within it's V4L2 subdev driver. The
driver
> is supposed to support possibly all S5P SoCs variants and the PHY handling
> details need to be hidden in the platform code. The functionality behind
> "dphy_csis" clocks is not exact a functionality of the clock, but they
have
> common features. If the clock API rules are to strict to accept this kind
> of usage then I'm willing to create some intermediate layer that will
finally
> solve PHY handling for MIPI-CSI, MIPI-DSIM, USB, SATA.. devices, without
> issues
> on a common kernel binary for multiple boards.
> 
> 
> The patch series contains:
> [PATCH 1/3] ARM: S5P: Rename MIPI-CSIS header and update Copyright
> [PATCH 2/3] ARM: S5PV210: Add clock entries for MIPI DPHY control
> [PATCH 3/3] ARM: EXYNOS4: Add clock entries for MIPI DPHY control
> 
> Rebased onto kgene-for-next branch at:
> git://git.kernel.org/pub/scm/linux/kernel/git/kgene/linux-samsung.git
> 

Maybe we discussed about this ago.
I remember, we agree that to control phy cannot be handled in clock part.

And didn't say to make some kind of common s5p phy setup/control function?
http://lists.infradead.org/pipermail/linux-arm-kernel/2011-January/038038.ht
ml

I thought it is possible to make it even though some registers is in
different place.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
