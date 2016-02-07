From: lkp@intel.com (kbuild test robot)
Date: Sun, 7 Feb 2016 18:27:19 +0800
Subject: [PATCH v7 2/4] tee: generic TEE subsystem
In-Reply-To: <1454318140-7962-3-git-send-email-jens.wiklander@linaro.org>
Message-ID: <201602071853.LXR6JlCz%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jens,

[auto build test ERROR on robh/for-next]
[also build test ERROR on v4.5-rc2 next-20160205]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jens-Wiklander/generic-TEE-subsystem/20160201-172318
base:   https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux for-next
config: x86_64-randconfig-x012-02041016 (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All errors (new ones prefixed by >>):

   drivers/built-in.o: In function `pool_res_mem_destroy':
>> tee_shm_pool.c:(.text+0x2941a6): undefined reference to `gen_pool_destroy'
   tee_shm_pool.c:(.text+0x2941af): undefined reference to `gen_pool_destroy'
   drivers/built-in.o: In function `pool_res_mem_mgr_init':
>> tee_shm_pool.c:(.text+0x29420b): undefined reference to `gen_pool_create'
>> tee_shm_pool.c:(.text+0x294221): undefined reference to `gen_pool_best_fit'
>> tee_shm_pool.c:(.text+0x294229): undefined reference to `gen_pool_set_algo'
>> tee_shm_pool.c:(.text+0x294240): undefined reference to `gen_pool_add_virt'
   tee_shm_pool.c:(.text+0x29424e): undefined reference to `gen_pool_destroy'
   drivers/built-in.o: In function `tee_shm_pool_alloc_res_mem':
>> (.text+0x294303): undefined reference to `gen_pool_destroy'
   drivers/built-in.o: In function `pool_op_gen_free':
>> tee_shm_pool.c:(.text+0x294335): undefined reference to `gen_pool_free'
   drivers/built-in.o: In function `pool_op_gen_alloc':
>> tee_shm_pool.c:(.text+0x294387): undefined reference to `gen_pool_alloc'
>> tee_shm_pool.c:(.text+0x2943a0): undefined reference to `gen_pool_virt_to_phys'

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 23391 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160207/6e29d231/attachment-0001.obj>
