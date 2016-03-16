From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 Mar 2016 23:00:10 +0800
Subject: [PATCH v12 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1458134885-6748-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201603162215.JRlvsJLx%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.5 next-20160316]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20160316-213031
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
   drivers/gpu/drm/bridge/parade-ps8640.c:114:30: sparse: invalid initializer
   drivers/gpu/drm/bridge/parade-ps8640.c:430:24: sparse: undefined identifier 'of_find_mipi_dsi_host_by_node'
   drivers/gpu/drm/bridge/parade-ps8640.c:114:37: warning: excess elements in scalar initializer
    static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
                                        ^
   drivers/gpu/drm/bridge/parade-ps8640.c:114:37: note: (near initialization for 'hw_chip_id')
   drivers/gpu/drm/bridge/parade-ps8640.c:114:43: warning: excess elements in scalar initializer
    static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
                                              ^
   drivers/gpu/drm/bridge/parade-ps8640.c:114:43: note: (near initialization for 'hw_chip_id')
   drivers/gpu/drm/bridge/parade-ps8640.c:114:49: warning: excess elements in scalar initializer
    static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
                                                    ^
   drivers/gpu/drm/bridge/parade-ps8640.c:114:49: note: (near initialization for 'hw_chip_id')
   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_bridge_attach':
   drivers/gpu/drm/bridge/parade-ps8640.c:430:10: error: implicit declaration of function 'of_find_mipi_dsi_host_by_node' [-Werror=implicit-function-declaration]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
             ^
   drivers/gpu/drm/bridge/parade-ps8640.c:430:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
           ^
   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_check_chip_id':
>> drivers/gpu/drm/bridge/parade-ps8640.c:717:21: warning: passing argument 2 of 'memcmp' makes pointer from integer without a cast [-Wint-conversion]
     return memcmp(buf, hw_chip_id, sizeof(buf));
                        ^
   In file included from include/linux/bitmap.h:8:0,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/cpumask.h:4,
                    from arch/x86/include/asm/msr.h:10,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/firmware.h:6,
                    from drivers/gpu/drm/bridge/parade-ps8640.c:16:
   include/linux/string.h:112:12: note: expected 'const void *' but argument is of type 'u8 {aka const unsigned char}'
    extern int memcmp(const void *,const void *,__kernel_size_t);
               ^
   cc1: some warnings being treated as errors

sparse warnings: (new ones prefixed by >>)

   include/linux/compiler.h:228:8: sparse: attribute 'no_sanitize_address': unknown attribute
>> drivers/gpu/drm/bridge/parade-ps8640.c:114:30: sparse: invalid initializer
   drivers/gpu/drm/bridge/parade-ps8640.c:430:24: sparse: undefined identifier 'of_find_mipi_dsi_host_by_node'
   drivers/gpu/drm/bridge/parade-ps8640.c:114:37: warning: excess elements in scalar initializer
    static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
                                        ^
   drivers/gpu/drm/bridge/parade-ps8640.c:114:37: note: (near initialization for 'hw_chip_id')
   drivers/gpu/drm/bridge/parade-ps8640.c:114:43: warning: excess elements in scalar initializer
    static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
                                              ^
   drivers/gpu/drm/bridge/parade-ps8640.c:114:43: note: (near initialization for 'hw_chip_id')
   drivers/gpu/drm/bridge/parade-ps8640.c:114:49: warning: excess elements in scalar initializer
    static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
                                                    ^
   drivers/gpu/drm/bridge/parade-ps8640.c:114:49: note: (near initialization for 'hw_chip_id')
   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_bridge_attach':
   drivers/gpu/drm/bridge/parade-ps8640.c:430:10: error: implicit declaration of function 'of_find_mipi_dsi_host_by_node' [-Werror=implicit-function-declaration]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
             ^
   drivers/gpu/drm/bridge/parade-ps8640.c:430:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
           ^
   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_check_chip_id':
   drivers/gpu/drm/bridge/parade-ps8640.c:717:21: warning: passing argument 2 of 'memcmp' makes pointer from integer without a cast [-Wint-conversion]
     return memcmp(buf, hw_chip_id, sizeof(buf));
                        ^
   In file included from include/linux/bitmap.h:8:0,
                    from include/linux/cpumask.h:11,
                    from arch/x86/include/asm/cpumask.h:4,
                    from arch/x86/include/asm/msr.h:10,
                    from arch/x86/include/asm/processor.h:20,
                    from arch/x86/include/asm/thread_info.h:52,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/firmware.h:6,
                    from drivers/gpu/drm/bridge/parade-ps8640.c:16:
   include/linux/string.h:112:12: note: expected 'const void *' but argument is of type 'u8 {aka const unsigned char}'
    extern int memcmp(const void *,const void *,__kernel_size_t);
               ^
   cc1: some warnings being treated as errors

vim +/memcmp +717 drivers/gpu/drm/bridge/parade-ps8640.c

   701	
   702		ret = ps8640_wait_rom_idle(ps_bridge);
   703		if (ret) {
   704			dev_err(dev, "fail wait rom idle: %d\n", ret);
   705			return ret;
   706		}
   707	
   708		return 0;
   709	}
   710	
   711	static int ps8640_check_chip_id(struct ps8640 *ps_bridge)
   712	{
   713		struct i2c_client *client = ps_bridge->page[4];
   714		u8 buf[4];
   715	
   716		ps8640_read(client, PAGE4_REV_L, buf, 4);
 > 717		return memcmp(buf, hw_chip_id, sizeof(buf));
   718	}
   719	
   720	static int ps8640_validate_firmware(struct ps8640 *ps_bridge,
   721					    const struct firmware *fw)
   722	{
   723		struct i2c_client *client = ps_bridge->page[0];
   724		u16 fw_chip_id;
   725	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53172 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160316/92f6686e/attachment-0001.obj>
