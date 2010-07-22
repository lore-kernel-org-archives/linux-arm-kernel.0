From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Thu, 22 Jul 2010 11:21:09 +0100
Subject: [PATCH v4 7/7] ARM: S5PV210: Initial CPUFREQ Support
In-Reply-To: <1279790573-24179-8-git-send-email-myungjoo.ham@samsung.com>
References: <1279790573-24179-1-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-2-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-3-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-4-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-5-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-6-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-7-git-send-email-myungjoo.ham@samsung.com>
	<1279790573-24179-8-git-send-email-myungjoo.ham@samsung.com>
Message-ID: <20100722102109.GI10930@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 22, 2010 at 06:22:53PM +0900, MyungJoo Ham wrote:
> S5PV210 CPUFREQ Support.
> 
> This CPUFREQ may work without PMIC's DVS support. However, it is not
> as effective without DVS support as supposed. AVS is not supported in
> this version.
> 
> Note that CLK_SRC of some clocks including ARMCLK, G3D, G2D, MFC,
> and ONEDRAM are modified directly without updating clksrc_src
> representations of the clocks.  Because CPUFREQ reverts the CLK_SRC
> to the supposed values, this does not affect the consistency as long as
> there are no other modules that modifies clock sources of ARMCLK, G3D,
> G2D, MFC, and ONEDRAM (and only CPUFREQ should have the control). As
> soon as clock framework is settled, we may update source clocks
> (.parent field) of those clocks accordingly later.
> 
> Signed-off-by: MyungJoo Ham <myungjoo.ham@samsung.com>
> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>

Still

Acked-by: Mark Brown <broonie@opensource.wolfsonmicro.com>
