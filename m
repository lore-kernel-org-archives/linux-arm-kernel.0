From: lkp@intel.com (kbuild test robot)
Date: Wed, 16 Mar 2016 22:39:30 +0800
Subject: [PATCH v12 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1458134885-6748-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201603162220.ZaPnQcDb%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test WARNING on drm/drm-next]
[also build test WARNING on v4.5 next-20160316]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20160316-213031
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

>> drivers/gpu/drm/bridge/parade-ps8640.c:114:37: warning: excess elements in scalar initializer
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
>> drivers/gpu/drm/bridge/parade-ps8640.c:717:21: warning: passing argument 2 of '__builtin_memcmp' makes pointer from integer without a cast [-Wint-conversion]
     return memcmp(buf, hw_chip_id, sizeof(buf));
                        ^
   In file included from arch/x86/include/asm/string.h:2:0,
                    from include/linux/string.h:18,
                    from arch/x86/include/asm/page_32.h:34,
                    from arch/x86/include/asm/page.h:13,
                    from arch/x86/include/asm/thread_info.h:11,
                    from include/linux/thread_info.h:54,
                    from arch/x86/include/asm/preempt.h:6,
                    from include/linux/preempt.h:59,
                    from include/linux/spinlock.h:50,
                    from include/linux/mmzone.h:7,
                    from include/linux/gfp.h:5,
                    from include/linux/firmware.h:6,
                    from drivers/gpu/drm/bridge/parade-ps8640.c:16:
   arch/x86/include/asm/string_32.h:202:16: note: expected 'const void *' but argument is of type 'u8 {aka const unsigned char}'
    #define memcmp __builtin_memcmp
                   ^
>> include/linux/string.h:112:12: note: in expansion of macro 'memcmp'
    extern int memcmp(const void *,const void *,__kernel_size_t);
               ^
   cc1: some warnings being treated as errors

vim +114 drivers/gpu/drm/bridge/parade-ps8640.c

    98		struct mipi_dsi_device dsi;
    99		struct i2c_client *page[8];
   100		struct i2c_client *ddc_i2c;
   101		struct regulator_bulk_data supplies[2];
   102		struct drm_panel *panel;
   103		struct gpio_desc *gpio_rst_n;
   104		struct gpio_desc *gpio_slp_n;
   105		struct gpio_desc *gpio_mode_sel_n;
   106		bool enabled;
   107	
   108		/* firmware file info */
   109		bool in_fw_update;
   110		struct ps8640_info info;
   111	};
   112	
   113	static const u8 enc_ctrl_code[6] = {0xaa, 0x55, 0x50, 0x41, 0x52, 0x44};
 > 114	static const u8 hw_chip_id = {0x00, 0x0a, 0x00, 0x30};
   115	
   116	static int ps8640_read(struct i2c_client *client, u8 reg, u8 *data,
   117			       u16 data_len)
   118	{
   119		int ret;
   120		struct i2c_msg msgs[] = {
   121			{
   122			 .addr = client->addr,

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53508 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160316/68b62f5a/attachment-0001.obj>
