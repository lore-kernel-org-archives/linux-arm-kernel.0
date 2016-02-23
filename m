From: lkp@intel.com (kbuild test robot)
Date: Tue, 23 Feb 2016 16:27:20 +0800
Subject: [PATCH v11 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1456212937-7635-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201602231614.ijDQkkJH%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.5-rc5 next-20160223]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20160223-153819
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All errors (new ones prefixed by >>):

   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_bridge_attach':
>> drivers/gpu/drm/bridge/parade-ps8640.c:435:10: error: implicit declaration of function 'of_find_mipi_dsi_host_by_node' [-Werror=implicit-function-declaration]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
             ^
   drivers/gpu/drm/bridge/parade-ps8640.c:435:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
           ^
   cc1: some warnings being treated as errors

vim +/of_find_mipi_dsi_host_by_node +435 drivers/gpu/drm/bridge/parade-ps8640.c

   429			if (in_ep) {
   430				dsi_node = of_graph_get_remote_port_parent(in_ep);
   431				of_node_put(in_ep);
   432			}
   433		}
   434		if (dsi_node) {
 > 435			host = of_find_mipi_dsi_host_by_node(dsi_node);
   436			of_node_put(dsi_node);
   437			if (!host)
   438				return -ENODEV;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53317 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160223/4a6b5bb3/attachment-0001.obj>
