From: edubezval@gmail.com (Eduardo Valentin)
Date: Tue, 29 Mar 2016 08:45:59 -0700
Subject: [PATCH v3 0/4] thermal: hisilicon: enable power allocator for
 Hi6220
In-Reply-To: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
References: <1459250835-25561-1-git-send-email-leo.yan@linaro.org>
Message-ID: <20160329154548.GE1855@localhost.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 07:27:11PM +0800, Leo Yan wrote:
> Hi6220 has octa-core so it has quite high power consumption when run
> benchmark and introduces high temperature for SoC. So need enable
> thermal governor to control temperature and also cannot hurt much for
> performance after impose cooling operations on CPU.
> 
> This patch series is to enable power allocator for Hi6220. Patch 1 is to
> change "hysteresis" as optional property for trip points, so when enable
> power allocator governor we can ignore this property.
> 
> During profiling also found two issues for thermal sensor's driver. The
> power allocator just uses only one sensor, so patch 2 is to fix sensor
> driver to let it can initialize driver successfully with only enabling
> one sensor; patch 3 is to dismiss warning of IRQ imbalance enabling.
> 
> After profiling on Hikey, the power model has been simplized with only
> dynamic coefficient, and now it's convienence to pass it from CPU node.
> So patch 4 and 5 bind sensor and pass power model parameters.
> 
> This patch series have been tested on 96boards Hikey.

Applied patches 1 and 2 in my fixes branch. Patches 3 and 4 need to go
via the hisi platform tree. You may add my

Acked-by: Eduardo Valentin <edubezval@gmail.com>

on patches 3 and 4 if you want.
