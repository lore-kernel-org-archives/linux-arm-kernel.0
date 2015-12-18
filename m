From: lkp@intel.com (kbuild test robot)
Date: Fri, 18 Dec 2015 18:10:37 +0800
Subject: [PATCH v7 4/5] iommu/mediatek: Add mt8173 IOMMU driver
In-Reply-To: <1450426183-1571-5-git-send-email-yong.wu@mediatek.com>
Message-ID: <201512181807.TNzdBfeR%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yong,

[auto build test ERROR on tegra/for-next]
[also build test ERROR on v4.4-rc5]
[cannot apply to iommu/next next-20151217]

url:    https://github.com/0day-ci/linux/commits/Yong-Wu/MT8173-IOMMU-SUPPORT/20151218-161550
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux for-next
config: parisc-allyesconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=parisc 

All error/warnings (new ones prefixed by >>):

   drivers/iommu/dma-iommu.c: In function '__iommu_dma_alloc_pages':
   drivers/iommu/dma-iommu.c:198:3: error: implicit declaration of function 'vzalloc' [-Werror=implicit-function-declaration]
      pages = vzalloc(array_size);
      ^
   drivers/iommu/dma-iommu.c:198:9: warning: assignment makes pointer from integer without a cast
      pages = vzalloc(array_size);
            ^
   drivers/iommu/dma-iommu.c: In function 'iommu_dma_free':
>> drivers/iommu/dma-iommu.c:256:12: error: 'DMA_ERROR_CODE' undeclared (first use in this function)
     *handle = DMA_ERROR_CODE;
               ^
   drivers/iommu/dma-iommu.c:256:12: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/dma-iommu.c: In function 'iommu_dma_alloc':
   drivers/iommu/dma-iommu.c:288:12: error: 'DMA_ERROR_CODE' undeclared (first use in this function)
     *handle = DMA_ERROR_CODE;
               ^
   drivers/iommu/dma-iommu.c: In function 'iommu_dma_map_page':
   drivers/iommu/dma-iommu.c:369:10: error: 'DMA_ERROR_CODE' undeclared (first use in this function)
      return DMA_ERROR_CODE;
             ^
   drivers/iommu/dma-iommu.c: In function '__invalidate_sg':
   drivers/iommu/dma-iommu.c:419:28: error: 'DMA_ERROR_CODE' undeclared (first use in this function)
      if (sg_dma_address(s) != DMA_ERROR_CODE)
                               ^
   drivers/iommu/dma-iommu.c: In function 'iommu_dma_mapping_error':
   drivers/iommu/dma-iommu.c:523:21: error: 'DMA_ERROR_CODE' undeclared (first use in this function)
     return dma_addr == DMA_ERROR_CODE;
                        ^
>> drivers/iommu/dma-iommu.c:524:1: warning: control reaches end of non-void function [-Wreturn-type]
    }
    ^
   cc1: some warnings being treated as errors
--
   drivers/iommu/mtk_iommu.c:174:2: warning: initialization from incompatible pointer type
     .tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
     ^
   drivers/iommu/mtk_iommu.c:174:2: warning: (near initialization for 'mtk_iommu_gather_ops.tlb_add_flush')
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_config':
>> drivers/iommu/mtk_iommu.c:223:22: error: 'struct dev_archdata' has no member named 'iommu'
     head = dev->archdata.iommu;
                         ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_domain_finalise':
   drivers/iommu/mtk_iommu.c:247:4: error: 'IO_PGTABLE_QUIRK_NO_PERMS' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_NO_PERMS |
       ^
   drivers/iommu/mtk_iommu.c:247:4: note: each undeclared identifier is reported only once for each function it appears in
   drivers/iommu/mtk_iommu.c:248:4: error: 'IO_PGTABLE_QUIRK_TLBI_ON_MAP' undeclared (first use in this function)
       IO_PGTABLE_QUIRK_TLBI_ON_MAP,
       ^
   drivers/iommu/mtk_iommu.c:256:34: error: 'ARM_V7S' undeclared (first use in this function)
     dom->iop = alloc_io_pgtable_ops(ARM_V7S, &dom->cfg, data);
                                     ^
   drivers/iommu/mtk_iommu.c:265:27: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                              ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_attach_device':
   drivers/iommu/mtk_iommu.c:303:52: error: 'struct dev_archdata' has no member named 'iommu'
     struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
                                                       ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_detach_device':
   drivers/iommu/mtk_iommu.c:331:52: error: 'struct dev_archdata' has no member named 'iommu'
     struct mtk_iommu_client_priv *priv = dev->archdata.iommu;
                                                       ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_add_device':
   drivers/iommu/mtk_iommu.c:387:20: error: 'struct dev_archdata' has no member named 'iommu'
     if (!dev->archdata.iommu) /* Not a iommu client device */
                       ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_remove_device':
   drivers/iommu/mtk_iommu.c:402:22: error: 'struct dev_archdata' has no member named 'iommu'
     head = dev->archdata.iommu;
                         ^
   drivers/iommu/mtk_iommu.c:411:15: error: 'struct dev_archdata' has no member named 'iommu'
     dev->archdata.iommu = NULL;
                  ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_device_group':
   drivers/iommu/mtk_iommu.c:421:22: error: 'struct dev_archdata' has no member named 'iommu'
     priv = dev->archdata.iommu;
                         ^
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_of_xlate':
   drivers/iommu/mtk_iommu.c:446:20: error: 'struct dev_archdata' has no member named 'iommu'
     if (!dev->archdata.iommu) {
                       ^
   drivers/iommu/mtk_iommu.c:457:16: error: 'struct dev_archdata' has no member named 'iommu'
      dev->archdata.iommu = head;
                   ^
   drivers/iommu/mtk_iommu.c:461:23: error: 'struct dev_archdata' has no member named 'iommu'
      head = dev->archdata.iommu;
                          ^
   drivers/iommu/mtk_iommu.c:477:15: error: 'struct dev_archdata' has no member named 'iommu'
     dev->archdata.iommu = NULL;
                  ^
   In file included from include/linux/scatterlist.h:8:0,
                    from include/linux/iommu.h:26,
                    from include/linux/dma-iommu.h:23,
                    from drivers/iommu/mtk_iommu.c:16:
   drivers/iommu/mtk_iommu.c: In function 'mtk_iommu_resume':
   drivers/iommu/mtk_iommu.c:683:35: error: 'struct io_pgtable_cfg' has no member named 'arm_v7s_cfg'
     writel_relaxed(data->m4u_dom->cfg.arm_v7s_cfg.ttbr[0],
                                      ^
   arch/parisc/include/asm/io.h:228:40: note: in definition of macro 'writel_relaxed'
    #define writel_relaxed(l, addr) writel(l, addr)
                                           ^
   drivers/iommu/mtk_iommu.c: At top level:
   drivers/iommu/mtk_iommu.c:662:12: warning: 'mtk_iommu_suspend' defined but not used [-Wunused-function]
    static int mtk_iommu_suspend(struct device *dev)
               ^
   drivers/iommu/mtk_iommu.c:677:12: warning: 'mtk_iommu_resume' defined but not used [-Wunused-function]
    static int mtk_iommu_resume(struct device *dev)
               ^

vim +223 drivers/iommu/mtk_iommu.c

   168		/* Clear the CPE status */
   169		writel_relaxed(0, data->base + REG_MMU_CPE_DONE);
   170	}
   171	
   172	static const struct iommu_gather_ops mtk_iommu_gather_ops = {
   173		.tlb_flush_all = mtk_iommu_tlb_flush_all,
 > 174		.tlb_add_flush = mtk_iommu_tlb_add_flush_nosync,
   175		.tlb_sync = mtk_iommu_tlb_sync,
   176	};
   177	
   178	static irqreturn_t mtk_iommu_isr(int irq, void *dev_id)
   179	{
   180		struct mtk_iommu_data *data = dev_id;
   181		struct mtk_iommu_domain *dom = data->m4u_dom;
   182		u32 int_state, regval, fault_iova, fault_pa;
   183		unsigned int fault_larb, fault_port;
   184		bool layer, write;
   185	
   186		/* Read error info from registers */
   187		int_state = readl_relaxed(data->base + REG_MMU_FAULT_ST1);
   188		fault_iova = readl_relaxed(data->base + REG_MMU_FAULT_VA);
   189		layer = fault_iova & F_MMU_FAULT_VA_LAYER_BIT;
   190		write = fault_iova & F_MMU_FAULT_VA_WRITE_BIT;
   191		fault_iova &= F_MMU_FAULT_VA_MSK;
   192		fault_pa = readl_relaxed(data->base + REG_MMU_INVLD_PA);
   193		regval = readl_relaxed(data->base + REG_MMU_INT_ID);
   194		fault_larb = F_MMU0_INT_ID_LARB_ID(regval);
   195		fault_port = F_MMU0_INT_ID_PORT_ID(regval);
   196	
   197		if (report_iommu_fault(&dom->domain, data->dev, fault_iova,
   198				       write ? IOMMU_FAULT_WRITE : IOMMU_FAULT_READ)) {
   199			dev_err_ratelimited(
   200				data->dev,
   201				"fault type=0x%x iova=0x%x pa=0x%x larb=%d port=%d layer=%d %s\n",
   202				int_state, fault_iova, fault_pa, fault_larb, fault_port,
   203				layer, write ? "write" : "read");
   204		}
   205	
   206		/* Interrupt clear */
   207		regval = readl_relaxed(data->base + REG_MMU_INT_CONTROL0);
   208		regval |= F_INT_CLR_BIT;
   209		writel_relaxed(regval, data->base + REG_MMU_INT_CONTROL0);
   210	
   211		mtk_iommu_tlb_flush_all(data);
   212	
   213		return IRQ_HANDLED;
   214	}
   215	
   216	static void mtk_iommu_config(struct mtk_iommu_data *data,
   217				     struct device *dev, bool enable)
   218	{
   219		struct mtk_iommu_client_priv *head, *cur, *next;
   220		struct mtk_smi_larb_iommu    *larb_mmu;
   221		unsigned int                 larbid, portid;
   222	
 > 223		head = dev->archdata.iommu;
   224		list_for_each_entry_safe(cur, next, &head->client, client) {
   225			larbid = MTK_M4U_TO_LARB(cur->mtk_m4u_id);
   226			portid = MTK_M4U_TO_PORT(cur->mtk_m4u_id);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 43146 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151218/2cb94669/attachment-0001.obj>
