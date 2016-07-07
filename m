From: lkp@intel.com (kbuild test robot)
Date: Thu, 7 Jul 2016 09:25:17 +0800
Subject: [PATCH v6 18/18] remoteproc: core: Retry
 rproc_fw_config_virtio() if !rproc->table_ptr
In-Reply-To: <1467795276-21725-19-git-send-email-peter.griffin@linaro.org>
Message-ID: <201607070935.iuu6KqiK%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

[auto build test WARNING on robh/for-next]
[also build test WARNING on v4.7-rc6 next-20160706]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Peter-Griffin/Add-support-for-FDMA-DMA-controller-and-slim-core-rproc-found-on-STi-chipsets/20160706-170304
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git for-next
config: openrisc-allyesconfig (attached as .config)
compiler: or32-linux-gcc (GCC) 4.5.1-or32-1.0rc1
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All warnings (new ones prefixed by >>):

>> drivers/remoteproc/remoteproc_internal.h:52:13: warning: 'rproc_fw_config_virtio_cb' declared 'static' but never defined
>> drivers/remoteproc/remoteproc_internal.h:53:13: warning: 'rproc_fw_config_virtio' declared 'static' but never defined
--
   drivers/remoteproc/st_slim_rproc.c: In function 'slim_rproc_alloc':
   drivers/remoteproc/st_slim_rproc.c:288:10: warning: assignment discards qualifiers from pointer target type
   drivers/remoteproc/st_slim_rproc.c: At top level:
>> drivers/remoteproc/remoteproc_internal.h:52:13: warning: 'rproc_fw_config_virtio_cb' declared 'static' but never defined
>> drivers/remoteproc/remoteproc_internal.h:53:13: warning: 'rproc_fw_config_virtio' declared 'static' but never defined

vim +52 drivers/remoteproc/remoteproc_internal.h

    46	};
    47	
    48	/* from remoteproc_core.c */
    49	void rproc_release(struct kref *kref);
    50	irqreturn_t rproc_vq_interrupt(struct rproc *rproc, int vq_id);
    51	int rproc_boot_nowait(struct rproc *rproc);
  > 52	static void rproc_fw_config_virtio_cb(const struct firmware *fw, void *context);
  > 53	static void rproc_fw_config_virtio(const struct firmware *fw, struct rproc *rproc);
    54	
    55	
    56	/* from remoteproc_virtio.c */

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 37350 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160707/64f9304f/attachment-0001.obj>
