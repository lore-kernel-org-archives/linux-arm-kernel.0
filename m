From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 18 May 2016 16:30:01 +0200
Subject: [PATCH v3 0/2] nvmem: remove regmap dependency
In-Reply-To: <1462214174-469-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462214174-469-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <573C7C69.1050301@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Srinivas,

Am 02.05.2016 um 20:36 schrieb Srinivas Kandagatla:
> Hi Greg, 
>
> This is v3 patchset for the leftover 2 patches for nvmem regmap
> removal series [1]. These patches are based on char-misc tree.
>
> nvmem uses regmap_raw_read/write apis to read/write data from providers,
> With recent patch 922a9f936e40 ("regmap: mmio: Convert to regmap_bus
> and fix accessor usage") nvmem providers based on regmap-mmio stopped
> working, as nvmem core was using raw accessors.
> This issue can be fixed temporarly by moving to other regmap apis,
> but we might hit same issue in future, and regmap looks like an
> overdo for nvmem. Moving to interfaces based on read/write callbacks
> from providers would be more robust.

i noticed that Documentation/nvmem/nvmem.txt also needs a fix after
removing regmap dependency.
