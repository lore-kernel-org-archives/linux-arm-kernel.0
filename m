From: lkp@intel.com (kbuild test robot)
Date: Mon, 1 Feb 2016 13:06:49 +0800
Subject: [PATCH v8 2/2] drm/bridge: Add I2C based driver for ps8640 bridge
In-Reply-To: <1454300012-32552-2-git-send-email-jitao.shi@mediatek.com>
Message-ID: <201602011353.NBSd9H5X%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jitao,

[auto build test ERROR on drm/drm-next]
[also build test ERROR on v4.5-rc2 next-20160129]
[if your patch is applied to the wrong git tree, please drop us a note to help improving the system]

url:    https://github.com/0day-ci/linux/commits/Jitao-Shi/Documentation-bridge-Add-documentation-for-ps8640-DT-properties/20160201-121553
base:   git://people.freedesktop.org/~airlied/linux.git drm-next
config: x86_64-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All error/warnings (new ones prefixed by >>):

   drivers/gpu/drm/bridge/parade-ps8640.c: In function 'ps8640_bridge_attach':
>> drivers/gpu/drm/bridge/parade-ps8640.c:400:10: error: implicit declaration of function 'of_find_mipi_dsi_host_by_node' [-Werror=implicit-function-declaration]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
             ^
>> drivers/gpu/drm/bridge/parade-ps8640.c:400:8: warning: assignment makes pointer from integer without a cast [-Wint-conversion]
      host = of_find_mipi_dsi_host_by_node(dsi_node);
           ^
   cc1: some warnings being treated as errors

vim +/of_find_mipi_dsi_host_by_node +400 drivers/gpu/drm/bridge/parade-ps8640.c

   394			if (in_ep) {
   395				dsi_node = of_graph_get_remote_port_parent(in_ep);
   396				of_node_put(in_ep);
   397			}
   398		}
   399		if (dsi_node) {
 > 400			host = of_find_mipi_dsi_host_by_node(dsi_node);
   401			of_node_put(dsi_node);
   402			if (!host)
   403				return -ENODEV;

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 50940 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160201/840ceb65/attachment-0001.obj>
