From: fengguang.wu@intel.com (kbuild test robot)
Date: Tue, 25 Jul 2017 02:31:45 +0800
Subject: [xlnx:master 798/812] drivers/dma//xilinx/xilinx_frmbuf.c:285:6:
 error: redefinition of 'xilinx_xdma_drm_config'
Message-ID: <201707250243.Azr7TUnG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx master
head:   5a5db6231107b7dbf97af0ae9a451d79e9d38203
commit: 166f3acd1fdde298178852d6db7c29ce80b13d76 [798/812] dma: xilinx: New driver for Video Framebuffer IP
config: ia64-allmodconfig (attached as .config)
compiler: ia64-linux-gcc (GCC) 6.2.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 166f3acd1fdde298178852d6db7c29ce80b13d76
        # save the attached .config to linux build tree
        make.cross ARCH=ia64 

All errors (new ones prefixed by >>):

>> drivers/dma//xilinx/xilinx_frmbuf.c:285:6: error: redefinition of 'xilinx_xdma_drm_config'
    void xilinx_xdma_drm_config(struct dma_chan *chan, u32 drm_fourcc)
         ^~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/dma//xilinx/xilinx_frmbuf.c:24:0:
   include/linux/dma/xilinx_frmbuf.h:52:20: note: previous definition of 'xilinx_xdma_drm_config' was here
    static inline void xilinx_xdma_drm_config(struct dma_chan *chan, u32 drm_fourcc)
                       ^~~~~~~~~~~~~~~~~~~~~~
>> drivers/dma//xilinx/xilinx_frmbuf.c:291:6: error: redefinition of 'xilinx_xdma_v4l2_config'
    void xilinx_xdma_v4l2_config(struct dma_chan *chan, u32 v4l2_fourcc)
         ^~~~~~~~~~~~~~~~~~~~~~~
   In file included from drivers/dma//xilinx/xilinx_frmbuf.c:24:0:
   include/linux/dma/xilinx_frmbuf.h:55:20: note: previous definition of 'xilinx_xdma_v4l2_config' was here
    static inline void xilinx_xdma_v4l2_config(struct dma_chan *chan,
                       ^~~~~~~~~~~~~~~~~~~~~~~

vim +/xilinx_xdma_drm_config +285 drivers/dma//xilinx/xilinx_frmbuf.c

   284	
 > 285	void xilinx_xdma_drm_config(struct dma_chan *chan, u32 drm_fourcc)
   286	{
   287		xilinx_xdma_set_config(chan, drm_fourcc, XDMA_DRM);
   288	
   289	} EXPORT_SYMBOL_GPL(xilinx_xdma_drm_config);
   290	
 > 291	void xilinx_xdma_v4l2_config(struct dma_chan *chan, u32 v4l2_fourcc)
   292	{
   293		xilinx_xdma_set_config(chan, v4l2_fourcc, XDMA_V4L2);
   294	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 45292 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170725/7a6e1ecd/attachment-0001.gz>
