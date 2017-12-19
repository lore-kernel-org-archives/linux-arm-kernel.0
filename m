From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 19 Dec 2017 18:41:23 +0800
Subject: [xlnx:2017.3_video_ea 6589/6615] include/linux/dmaengine.h:1409:
 undefined reference to `dma_request_slave_channel'
Message-ID: <201712191810.QmylPImO%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jeffrey,

It's probably a bug fix that unveils the link errors.

tree:   https://github.com/Xilinx/linux-xlnx 2017.3_video_ea
head:   57af48e31ef9c4a9fa54914afa723ce818c4c21a
commit: 62a7ed2f02d28f73f2c09d61ecbe1f289aecc6e5 [6589/6615] staging: xilinx: mixer: Initial commit of Xilinx Video Mixer IP DRM driver
config: i386-randconfig-s0-201751 (attached as .config)
compiler: gcc-6 (Debian 6.4.0-9) 6.4.0 20171026
reproduce:
        git checkout 62a7ed2f02d28f73f2c09d61ecbe1f289aecc6e5
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `__dma_request_slave_channel_compat':
>> include/linux/dmaengine.h:1409: undefined reference to `dma_request_slave_channel'
>> include/linux/dmaengine.h:1416: undefined reference to `__dma_request_channel'
>> include/linux/dmaengine.h:1409: undefined reference to `dma_request_slave_channel'
>> include/linux/dmaengine.h:1416: undefined reference to `__dma_request_channel'
   drivers/built-in.o: In function `pxa2xx_spi_dma_setup':
>> drivers/spi/spi-pxa2xx-dma.c:208: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `pxa2xx_spi_dma_release':
   drivers/spi/spi-pxa2xx-dma.c:222: undefined reference to `dma_release_channel'
   drivers/spi/spi-pxa2xx-dma.c:227: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `rockchip_spi_remove':
>> drivers/spi/spi-rockchip.c:821: undefined reference to `dma_release_channel'
   drivers/spi/spi-rockchip.c:823: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `rockchip_spi_probe':
>> drivers/spi/spi-rockchip.c:752: undefined reference to `dma_request_chan'
   drivers/spi/spi-rockchip.c:763: undefined reference to `dma_request_chan'
>> drivers/spi/spi-rockchip.c:774: undefined reference to `dma_get_slave_caps'
   drivers/spi/spi-rockchip.c:796: undefined reference to `dma_release_channel'
   drivers/spi/spi-rockchip.c:799: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `pch_spi_request_dma':
>> drivers/spi/spi-topcliff-pch.c:878: undefined reference to `__dma_request_channel'
   drivers/spi/spi-topcliff-pch.c:893: undefined reference to `__dma_request_channel'
>> drivers/spi/spi-topcliff-pch.c:897: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `pch_spi_release_dma':
   drivers/spi/spi-topcliff-pch.c:911: undefined reference to `dma_release_channel'
   drivers/spi/spi-topcliff-pch.c:915: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `usdhi6_dma_release':
>> drivers/mmc/host/usdhi6rol0.c:525: undefined reference to `dma_release_channel'
   drivers/mmc/host/usdhi6rol0.c:530: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `usdhi6_dma_request':
>> drivers/mmc/host/usdhi6rol0.c:683: undefined reference to `dma_request_slave_channel'
   drivers/mmc/host/usdhi6rol0.c:698: undefined reference to `dma_request_slave_channel'
   drivers/mmc/host/usdhi6rol0.c:716: undefined reference to `dma_release_channel'
   drivers/mmc/host/usdhi6rol0.c:719: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `Si5324_RatApprox':
>> drivers/staging/xilinx/clk/si5324drv.c:45: undefined reference to `__udivdi3'
>> drivers/staging/xilinx/clk/si5324drv.c:52: undefined reference to `__umoddi3'
   drivers/staging/xilinx/clk/si5324drv.c:56: undefined reference to `__udivdi3'
   drivers/built-in.o: In function `Si5324_FindN2ls':
   drivers/staging/xilinx/clk/si5324drv.c:95: undefined reference to `__udivdi3'
   drivers/staging/xilinx/clk/si5324drv.c:95: undefined reference to `__udivdi3'
   drivers/staging/xilinx/clk/si5324drv.c:124: undefined reference to `__udivdi3'
   drivers/staging/xilinx/clk/si5324drv.c:126: undefined reference to `__udivdi3'
   drivers/built-in.o:drivers/staging/xilinx/clk/si5324drv.c:189: more undefined references to `__udivdi3' follow
   drivers/built-in.o: In function `Si5324_CalcFreqSettings':
>> drivers/staging/xilinx/clk/si5324drv.c:312: undefined reference to `__divdi3'
   drivers/staging/xilinx/clk/si5324drv.c:316: undefined reference to `__divdi3'
   drivers/built-in.o: In function `xvmixer_drm_encoder_create':
>> drivers/staging/xilinx/xvmixer/xvmixer_drm_encoder.c:201: undefined reference to `of_find_device_by_node'
   drivers/built-in.o: In function `xilinx_drm_plane_destroy':
>> drivers/staging/xilinx/xvmixer/xvmixer_drm_plane.c:244: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `xvmixer_drm_plane_commit':
>> drivers/staging/xilinx/xvmixer/xvmixer_drm_plane.c:89: undefined reference to `xilinx_xdma_drm_config'
   drivers/built-in.o: In function `xvmixer_drm_mixer_init_plane':
   drivers/staging/xilinx/xvmixer/xvmixer_drm_plane.c:447: undefined reference to `dma_release_channel'
   drivers/built-in.o: In function `xilinx_mixer_set_layer_buff_addr':
>> drivers/staging/xilinx/xvmixer/xilinx_mixer_hw.c:657: undefined reference to `__umoddi3'
>> drivers/staging/xilinx/xvmixer/xilinx_mixer_hw.c:657: undefined reference to `__umoddi3'
   drivers/built-in.o: In function `perf_remove':

vim +1409 include/linux/dmaengine.h

c13c8260 Chris Leech        2006-05-23  1392  
c13c8260 Chris Leech        2006-05-23  1393  int dma_async_device_register(struct dma_device *device);
c13c8260 Chris Leech        2006-05-23  1394  void dma_async_device_unregister(struct dma_device *device);
07f2211e Dan Williams       2009-01-05  1395  void dma_run_dependencies(struct dma_async_tx_descriptor *tx);
7bb587f4 Zhangfei Gao       2013-06-28  1396  struct dma_chan *dma_get_slave_channel(struct dma_chan *chan);
8010dad5 Stephen Warren     2013-11-26  1397  struct dma_chan *dma_get_any_slave_channel(struct dma_device *device);
59b5ec21 Dan Williams       2009-01-06  1398  #define dma_request_channel(mask, x, y) __dma_request_channel(&(mask), x, y)
864ef69b Matt Porter        2013-02-01  1399  #define dma_request_slave_channel_compat(mask, x, y, dev, name) \
864ef69b Matt Porter        2013-02-01  1400  	__dma_request_slave_channel_compat(&(mask), x, y, dev, name)
864ef69b Matt Porter        2013-02-01  1401  
864ef69b Matt Porter        2013-02-01  1402  static inline struct dma_chan
a53e28da Lars-Peter Clausen 2013-03-25  1403  *__dma_request_slave_channel_compat(const dma_cap_mask_t *mask,
a53e28da Lars-Peter Clausen 2013-03-25  1404  				  dma_filter_fn fn, void *fn_param,
1dc04288 Jarkko Nikula      2015-08-12  1405  				  struct device *dev, const char *name)
864ef69b Matt Porter        2013-02-01  1406  {
864ef69b Matt Porter        2013-02-01  1407  	struct dma_chan *chan;
864ef69b Matt Porter        2013-02-01  1408  
864ef69b Matt Porter        2013-02-01 @1409  	chan = dma_request_slave_channel(dev, name);
864ef69b Matt Porter        2013-02-01  1410  	if (chan)
864ef69b Matt Porter        2013-02-01  1411  		return chan;
864ef69b Matt Porter        2013-02-01  1412  
7dfffb95 Geert Uytterhoeven 2015-08-17  1413  	if (!fn || !fn_param)
7dfffb95 Geert Uytterhoeven 2015-08-17  1414  		return NULL;
7dfffb95 Geert Uytterhoeven 2015-08-17  1415  
864ef69b Matt Porter        2013-02-01 @1416  	return __dma_request_channel(mask, fn, fn_param);

:::::: The code at line 1409 was first introduced by commit
:::::: 864ef69b2d9b34e7c85baa9c5c601d5e735b208a dmaengine: add dma_request_slave_channel_compat()

:::::: TO: Matt Porter <mporter@ti.com>
:::::: CC: Vinod Koul <vinod.koul@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 23957 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171219/c72692a5/attachment-0001.gz>
