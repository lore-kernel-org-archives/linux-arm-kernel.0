From: lkp@intel.com (kbuild test robot)
Date: Sun, 6 Dec 2015 08:44:50 +0800
Subject: [PATCH v5 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1448272793-27232-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201512060814.Fqi6eJfv%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.4-rc3 next-20151203]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20151123-180220
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: mips-allmodconfig (attached as .config)
reproduce:
        wget https://git.kernel.org/cgit/linux/kernel/git/wfg/lkp-tests.git/plain/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=mips 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_prepare':
>> drivers/gpu/drm/bridge/parade-ps8640.c:183:2: error: implicit declaration of function 'gpiod_set_value' [-Werror=implicit-function-declaration]
     gpiod_set_value(ps_bridge->gpio_slp_n, 1);
     ^
   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_probe':
>> drivers/gpu/drm/bridge/parade-ps8640.c:399:31: error: implicit declaration of function 'devm_gpiod_get' [-Werror=implicit-function-declaration]
     ps_bridge->gpio_mode_sel_n = devm_gpiod_get(&client->dev, "mode-sel",
                                  ^
>> drivers/gpu/drm/bridge/parade-ps8640.c:400:11: error: 'GPIOD_OUT_HIGH' undeclared (first use in this function)
              GPIOD_OUT_HIGH);
              ^
   drivers/gpu/drm/bridge/parade-ps8640.c:400:11: note: each undeclared identifier is reported only once for each function it appears in
   cc1: some warnings being treated as errors

vim +/gpiod_set_value +183 drivers/gpu/drm/bridge/parade-ps8640.c

   177		err = regulator_enable(ps_bridge->pwr_3v3_supply);
   178		if (err < 0) {
   179			DRM_ERROR("failed to enable vdd33-supply: %d\n", err);
   180			goto err_regulator_disable;
   181		}
   182	
 > 183		gpiod_set_value(ps_bridge->gpio_slp_n, 1);
   184		gpiod_set_value(ps_bridge->gpio_rst_n, 0);
   185		usleep_range(500, 700);
   186		gpiod_set_value(ps_bridge->gpio_rst_n, 1);

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 39669 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151206/d1adaf31/attachment-0001.obj>
