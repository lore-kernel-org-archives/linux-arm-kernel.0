From: nsekhar@ti.com (Sekhar Nori)
Date: Fri, 28 Oct 2016 15:18:33 +0530
Subject: [PATCH] ARM: davinci: Add full regulator constraints for non-DT
 boot
In-Reply-To: <20161026194155.14304-1-ahaslam@baylibre.com>
References: <20161026194155.14304-1-ahaslam@baylibre.com>
Message-ID: <a153fe5b-9242-a509-1404-c1bea4c9e5bf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 27 October 2016 01:11 AM, ahaslam at baylibre.com wrote:
> From: Axel Haslam <ahaslam@baylibre.com>
> 
> The phy framework requests an optional "phy" regulator. If it does
> not find one, it returns -EPROBE_DEFER. In the case of non-DT boot
> for the omap138-lcdk board, this would prevent the usb11 phy to probe
> correctly and ohci would not enumerate.
> 
> By calling "regulator_has_full_constraints", An error would be returned
> instead of DEFER for the regulator, and the probe of the phy driver can
> continue normally without a regulator.
> 
> Signed-off-by: Axel Haslam <ahaslam@baylibre.com>

Applied to v4.10/soc branch.

Thanks,
Sekhar
