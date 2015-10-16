From: lkp@intel.com (kbuild test robot)
Date: Sat, 17 Oct 2015 02:14:04 +0800
Subject: [RFC 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1444997709-57293-2-git-send-email-ck.hu@mediatek.com>
Message-ID: <201510170222.YOuOZJGv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test ERROR on drm-exynos/exynos-drm/for-next -- if it's inappropriate base, please suggest rules for selecting the more suitable base]

url:    https://github.com/0day-ci/linux/commits/CK-Hu/Dcumentation-bridge-Add-documentation-for-ps8640-DT-properties/20151016-201658
config: s390-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=s390 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_prepare':
>> drivers/gpu/drm/bridge/parade-ps8640.c:178:2: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
     gpiod_set_value(ps_bridge->gpio_pwr_n, 1);
     ^
   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_probe':
>> drivers/gpu/drm/bridge/parade-ps8640.c:391:2: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
     ps_bridge->gpio_mode_sel_n = devm_gpiod_get(&client->dev, "mode-sel",
     ^
>> drivers/gpu/drm/bridge/parade-ps8640.c:392:11: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
              GPIOD_OUT_HIGH);
              ^
   drivers/gpu/drm/bridge/parade-ps8640.c:392:11: note: each undeclared identifier is reported only once for each function it appears in
>> drivers/gpu/drm/bridge/parade-ps8640.c:399:2: error: implicit declaration of function 'gpiod_direction_output' [-Werror=implicit-function-declaration]
     ret = gpiod_direction_output(ps_bridge->gpio_mode_sel_n, 1);
     ^
   cc1: some warnings being treated as errors

vim +/gpiod_set_value +178 drivers/gpu/drm/bridge/parade-ps8640.c

   172		err = regulator_enable(ps_bridge->pwr_3v3_supply);
   173		if (err < 0) {
   174			DRM_ERROR("failed to enable pwr_3v3_supply: %d\n", err);
   175			return;
   176		}
   177	
 > 178		gpiod_set_value(ps_bridge->gpio_pwr_n, 1);
   179		gpiod_set_value(ps_bridge->gpio_rst_n, 0);
   180		usleep_range(500, 700);
   181		gpiod_set_value(ps_bridge->gpio_rst_n, 1);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 38291 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151017/e3e49f4c/attachment-0001.obj>
