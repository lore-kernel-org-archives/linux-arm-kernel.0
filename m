From: lkp@intel.com (kbuild test robot)
Date: Wed, 23 Dec 2015 04:30:26 +0800
Subject: [PATCH RESEND v4] arm: remove !CPU_V6 and !GENERIC_ATOMIC64
 build dependencies for XEN
In-Reply-To: <alpine.DEB.2.02.1512221404060.3096@kaball.uk.xensource.com>
Message-ID: <201512230436.AjuWs7tn%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

[auto build test WARNING on arm/for-next]
[also build test WARNING on v4.4-rc6 next-20151222]

url:    https://github.com/0day-ci/linux/commits/Stefano-Stabellini/arm-remove-CPU_V6-and-GENERIC_ATOMIC64-build-dependencies-for-XEN/20151222-222129
base:   http://repo.or.cz/linux-2.6/linux-2.6-arm.git for-next
config: arm-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=arm 

All warnings (new ones prefixed by >>):

   drivers/gpu/drm/exynos/exynos_drm_ipp.c: In function 'ipp_get_mem_node':
>> drivers/gpu/drm/exynos/exynos_drm_ipp.c:585:4: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat=]
       DRM_DEBUG_KMS("i[%d]base[0x%x]hd[0x%lx]\n", i,
       ^
--
   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from include/linux/clk.h:16,
                    from drivers/gpu/drm/sti/sti_hqvdp.c:7:
   drivers/gpu/drm/sti/sti_hqvdp.c: In function 'sti_hqvdp_vtg_cb':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
>> drivers/gpu/drm/sti/sti_hqvdp.c:605:3: note: in expansion of macro 'dev_dbg'
      dev_dbg(hqvdp->dev, "%s Posted command:0x%x\n",
      ^
   drivers/gpu/drm/sti/sti_hqvdp.c: In function 'sti_hqvdp_atomic_update':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/gpu/drm/sti/sti_hqvdp.c:931:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(hqvdp->dev, "%s Posted command:0x%x\n",
     ^
--
   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from include/linux/list.h:8,
                    from include/linux/module.h:9,
                    from drivers/media/platform/soc_camera/mx3_camera.c:13:
   drivers/media/platform/soc_camera/mx3_camera.c: In function 'mx3_cam_dma_done':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
>> drivers/media/platform/soc_camera/mx3_camera.c:149:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(chan->device->dev, "callback cookie %d, active DMA 0x%08x\n",
     ^
   drivers/media/platform/soc_camera/mx3_camera.c: In function 'mx3_videobuf_queue':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/media/platform/soc_camera/mx3_camera.c:341:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(icd->parent, "Submitted cookie %d DMA 0x%08x\n",
     ^
   drivers/media/platform/soc_camera/mx3_camera.c: In function 'mx3_videobuf_release':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 5 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/media/platform/soc_camera/mx3_camera.c:370:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(icd->parent,
     ^
--
   drivers/net/ethernet/ti/davinci_cpdma.c: In function 'cpdma_desc_pool_create':
>> drivers/net/ethernet/ti/davinci_cpdma.c:182:18: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type
      pool->cpumap = dma_alloc_coherent(dev, size, &pool->phys,
                     ^
   In file included from arch/arm/include/asm/dma-mapping.h:49:0,
                    from include/linux/dma-mapping.h:87,
                    from drivers/net/ethernet/ti/davinci_cpdma.c:21:
   include/asm-generic/dma-mapping-common.h:286:21: note: expected 'dma_addr_t *' but argument is of type 'phys_addr_t *'
    static inline void *dma_alloc_coherent(struct device *dev, size_t size,
                        ^
--
   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from drivers/soc/ti/knav_qmss_queue.c:19:
   drivers/soc/ti/knav_qmss_queue.c: In function 'knav_queue_setup_region':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 9 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
>> drivers/soc/ti/knav_qmss_queue.c:1025:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(kdev->dev,
     ^
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 10 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
>> drivers/soc/ti/knav_qmss_queue.c:1025:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(kdev->dev,
     ^
   drivers/soc/ti/knav_qmss_queue.c: In function 'knav_queue_setup_link_ram':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/soc/ti/knav_qmss_queue.c:1175:3: note: in expansion of macro 'dev_dbg'
      dev_dbg(kdev->dev, "linkram0: phys:%x, virt:%p, size:%x\n",
      ^
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 4 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/soc/ti/knav_qmss_queue.c:1184:3: note: in expansion of macro 'dev_dbg'
      dev_dbg(kdev->dev, "linkram1: phys:%x, virt:%p, size:%x\n",
      ^
--
   In file included from include/linux/printk.h:277:0,
                    from include/linux/kernel.h:13,
                    from drivers/soc/ti/knav_qmss_acc.c:19:
   drivers/soc/ti/knav_qmss_acc.c: In function 'knav_acc_int_handler':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 7 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
>> drivers/soc/ti/knav_qmss_acc.c:125:2: note: in expansion of macro 'dev_dbg'
     dev_dbg(kdev->dev, "acc-irq: channel %d, list %d, virt %p, phys %x\n",
     ^
   drivers/soc/ti/knav_qmss_acc.c: In function 'knav_init_acc_range':
   include/linux/dynamic_debug.h:64:16: warning: format '%x' expects argument of type 'unsigned int', but argument 6 has type 'dma_addr_t' [-Wformat=]
     static struct _ddebug  __aligned(8)   \
                   ^
   include/linux/dynamic_debug.h:84:2: note: in expansion of macro 'DEFINE_DYNAMIC_DEBUG_METADATA'
     DEFINE_DYNAMIC_DEBUG_METADATA(descriptor, fmt);  \
     ^
   include/linux/device.h:1179:2: note: in expansion of macro 'dynamic_dev_dbg'
     dynamic_dev_dbg(dev, format, ##__VA_ARGS__); \
     ^
   drivers/soc/ti/knav_qmss_acc.c:594:3: note: in expansion of macro 'dev_dbg'
      dev_dbg(kdev->dev, "%s: channel %d, phys %08x, virt %8p\n",
      ^
--
   drivers/video/fbdev/da8xx-fb.c: In function 'fb_probe':
>> drivers/video/fbdev/da8xx-fb.c:1429:19: warning: passing argument 3 of 'dma_alloc_coherent' from incompatible pointer type
     par->vram_virt = dma_alloc_coherent(NULL,
                      ^
   In file included from arch/arm/include/asm/dma-mapping.h:49:0,
                    from include/linux/dma-mapping.h:87,
                    from drivers/video/fbdev/da8xx-fb.c:25:
   include/asm-generic/dma-mapping-common.h:286:21: note: expected 'dma_addr_t *' but argument is of type 'resource_size_t *'
    static inline void *dma_alloc_coherent(struct device *dev, size_t size,
                        ^
>> drivers/video/fbdev/da8xx-fb.c:1450:24: warning: passing argument 3 of 'dma_zalloc_coherent' from incompatible pointer type
     par->v_palette_base = dma_zalloc_coherent(NULL, PALETTE_SIZE,
                           ^
   In file included from drivers/video/fbdev/da8xx-fb.c:25:0:
   include/linux/dma-mapping.h:187:21: note: expected 'dma_addr_t *' but argument is of type 'resource_size_t *'
    static inline void *dma_zalloc_coherent(struct device *dev, size_t size,
                        ^
--
   In file included from include/linux/dma-mapping.h:87:0,
                    from include/linux/dma-buf.h:31,
                    from drivers/gpu/drm/armada/armada_gem.c:8:
   drivers/gpu/drm/armada/armada_gem.c: In function 'armada_gem_alloc_private_object':
>> arch/arm/include/asm/dma-mapping.h:16:24: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
                           ^
>> drivers/gpu/drm/armada/armada_gem.c:204:18: note: in expansion of macro 'DMA_ERROR_CODE'
     obj->dev_addr = DMA_ERROR_CODE;
                     ^
   drivers/gpu/drm/armada/armada_gem.c: In function 'armada_gem_alloc_object':
>> arch/arm/include/asm/dma-mapping.h:16:24: warning: large integer implicitly truncated to unsigned type [-Woverflow]
    #define DMA_ERROR_CODE (~(dma_addr_t)0x0)
                           ^
   drivers/gpu/drm/armada/armada_gem.c:228:18: note: in expansion of macro 'DMA_ERROR_CODE'
     obj->dev_addr = DMA_ERROR_CODE;
                     ^

vim +585 drivers/gpu/drm/exynos/exynos_drm_ipp.c

c4a856a7 Andrzej Hajda   2014-08-28  569  		DRM_DEBUG_KMS("i[%d]handle[0x%x]\n", i, qbuf->handle[i]);
c4a856a7 Andrzej Hajda   2014-08-28  570  
c4a856a7 Andrzej Hajda   2014-08-28  571  		/* get dma address by handle */
c4a856a7 Andrzej Hajda   2014-08-28  572  		if (qbuf->handle[i]) {
c4a856a7 Andrzej Hajda   2014-08-28  573  			dma_addr_t *addr;
c4a856a7 Andrzej Hajda   2014-08-28  574  
c4a856a7 Andrzej Hajda   2014-08-28  575  			addr = exynos_drm_gem_get_dma_addr(drm_dev,
d9b9734c Andrzej Hajda   2014-09-02  576  					qbuf->handle[i], c_node->filp);
c4a856a7 Andrzej Hajda   2014-08-28  577  			if (IS_ERR(addr)) {
c4a856a7 Andrzej Hajda   2014-08-28  578  				DRM_ERROR("failed to get addr.\n");
c4a856a7 Andrzej Hajda   2014-08-28  579  				ipp_put_mem_node(drm_dev, c_node, m_node);
c4a856a7 Andrzej Hajda   2014-08-28  580  				return ERR_PTR(-EFAULT);
c4a856a7 Andrzej Hajda   2014-08-28  581  			}
c4a856a7 Andrzej Hajda   2014-08-28  582  
c4a856a7 Andrzej Hajda   2014-08-28  583  			buf_info->handles[i] = qbuf->handle[i];
c4a856a7 Andrzej Hajda   2014-08-28  584  			buf_info->base[i] = *addr;
c4a856a7 Andrzej Hajda   2014-08-28 @585  			DRM_DEBUG_KMS("i[%d]base[0x%x]hd[0x%lx]\n", i,
c4a856a7 Andrzej Hajda   2014-08-28  586  				      buf_info->base[i], buf_info->handles[i]);
c4a856a7 Andrzej Hajda   2014-08-28  587  		}
c4a856a7 Andrzej Hajda   2014-08-28  588  	}
c4a856a7 Andrzej Hajda   2014-08-28  589  
c4a856a7 Andrzej Hajda   2014-08-28  590  	mutex_lock(&c_node->mem_lock);
e44bf6b7 Beata Michalska 2015-03-04  591  	if (ipp_validate_mem_node(drm_dev, m_node, c_node)) {
e44bf6b7 Beata Michalska 2015-03-04  592  		ipp_put_mem_node(drm_dev, c_node, m_node);
e44bf6b7 Beata Michalska 2015-03-04  593  		mutex_unlock(&c_node->mem_lock);

:::::: The code at line 585 was first introduced by commit
:::::: c4a856a733b0aa3c62ce53efa20cc09feefb7739 drm/exynos/ipp: move nodes cleaning to separate function

:::::: TO: Andrzej Hajda <a.hajda@samsung.com>
:::::: CC: Inki Dae <daeinki@gmail.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 54806 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151223/e8227e0c/attachment-0001.obj>
