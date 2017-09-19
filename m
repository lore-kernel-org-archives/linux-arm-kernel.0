From: jeffy.chen@rock-chips.com (jeffy)
Date: Tue, 19 Sep 2017 11:16:32 +0800
Subject: [PATCH v11 2/2] ASoC: rockchip: Use bus_type to distinguish rt5514
 dsp from rt5514 codec
In-Reply-To: <20170918191524.GI173745@google.com>
References: <20170918111435.11411-1-jeffy.chen@rock-chips.com>
 <20170918111435.11411-2-jeffy.chen@rock-chips.com>
 <20170918191524.GI173745@google.com>
Message-ID: <59C08C10.7030806@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Matthias,

On 09/19/2017 03:15 AM, Matthias Kaehlcke wrote:
>> >+static int of_dev_node_match(struct device *dev, void *data)
>> >+{
>> >+	return dev->of_node == data;
>> >+}
> The same is done in different places, even with the same function name
> (drivers/i2c/i2c-core-of.c, drivers/mux/mux-core.c, ...), which
> suggests that we might want to have this function in <linux/of.h>
>

right, we are dupping this for bus_find_device in:
./arch/powerpc/platforms/pseries/ibmebus.c
./drivers/gpu/drm/drm_mipi_dsi.c
./drivers/hwtracing/coresight/of_coresight.c
./drivers/of/of_mdio.c
./drivers/of/platform.c
./drivers/i2c/i2c-core-of.c
./drivers/nvmem/core.c

and for class_find_device in:
./drivers/spi/spi.c
./drivers/fpga/fpga-mgr.c
./drivers/fpga/fpga-region.c
./drivers/fpga/fpga-bridge.c
./drivers/regulator/core.c
./drivers/mux/core.c
./drivers/net/phy/mdio_bus.c

and for component_match_add in:
./drivers/iommu/mtk_iommu.c
  (and a lot of drm drivers)
