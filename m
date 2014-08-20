From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Aug 2014 14:25:14 -0600
Subject: [PATCH v2 5/5] ARM: tegra: Add thermal reset (thermtrip) support
 to PMC
In-Reply-To: <1407933685-12404-6-git-send-email-mperttunen@nvidia.com>
References: <1407933685-12404-1-git-send-email-mperttunen@nvidia.com>
 <1407933685-12404-6-git-send-email-mperttunen@nvidia.com>
Message-ID: <53F5042A.7020603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/13/2014 06:41 AM, Mikko Perttunen wrote:
> This adds a device tree controlled option to enable PMC-based
> thermal reset in overheating situations. Thermtrip is supported on
> Tegra30, Tegra114 and Tegra124. The thermal reset only works when
> the thermal sensors are calibrated, so a soctherm driver is also
> required.

If calibration is required, presumably the soctherm must initialize 
before this thermtrip code can initialize, or this thermtrip logic might 
be triggered by uncalibrated sensors?

If so, then there needs to be some explicit mechanism to force the two 
drivers into probing in the right order.
