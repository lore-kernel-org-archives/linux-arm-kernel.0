From: stefan.wahren@i2se.com (Stefan Wahren)
Date: Wed, 1 Jun 2016 10:27:49 +0200
Subject: [PATCH v3 0/2] nvmem: remove regmap dependency
In-Reply-To: <1462214174-469-1-git-send-email-srinivas.kandagatla@linaro.org>
References: <1462214174-469-1-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <7eec3215-b455-6567-28a2-e2a860e1d3ec@i2se.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Greg,

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
>
> This patchset converts the nvmem core and nvmem provider drivers to
> use the new callbacks. Tested this patchset on qfprom and at24 drivers.
> Other driver are only compile tested, any testing on them would be great.
>
> Most of the patches have been applied to char-misc tree, these are the
> two patches which had some outstanding comments on mxs nvmemprovider,
> which are now fixed.
>
> Changes since v2:
>  - Fixed the mxs size and dt data pointer spotted by Stefan and Fabio
>
> Changes since v1:
>  - rebased mtk-efuse on top of char-misc
>  - addressed concerns raised by Stefan Wahren.
>
> [1] https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1130026.html
>
> Thanks,
> srini
>
> Srinivas Kandagatla (2):
>   nvmem: mtk-efuse: remove nvmem regmap dependency
>   nvmem: mxs-ocotp: remove nvmem regmap dependency
>
>  drivers/nvmem/Kconfig     |  1 -
>  drivers/nvmem/mtk-efuse.c | 47 ++++++++++++++++++---------
>  drivers/nvmem/mxs-ocotp.c | 83 +++++++++++++----------------------------------
>  3 files changed, 54 insertions(+), 77 deletions(-)
>

any objections about this series or is it still in queue?

Stefan
