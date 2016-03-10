From: lkp@intel.com (kbuild test robot)
Date: Thu, 10 Mar 2016 21:26:16 +0800
Subject: [PATCH v2 net-next 1/2] net: hns: fix return value of the
 function about rss
In-Reply-To: <1457616110-225844-2-git-send-email-yankejian@huawei.com>
Message-ID: <201603102149.TSoRVG6b%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kejian,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Kejian-Yan/net-hns-get-and-set-RSS-indirection-table-by-using-ethtool/20160310-210648
config: x86_64-allyesconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c: In function 'hns_get_rss':
>> drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1214:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c: In function 'hns_set_rss':
   drivers/net/ethernet/hisilicon/hns/hns_ethtool.c:1236:6: warning: unused variable 'ret' [-Wunused-variable]
     int ret;
         ^

vim +/ret +1214 drivers/net/ethernet/hisilicon/hns/hns_ethtool.c

6bc0ce7d Salil      2015-12-03  1198  		netdev_err(netdev,
6bc0ce7d Salil      2015-12-03  1199  			   "RSS feature is not supported on this hardware\n");
73f4f566 Kejian Yan 2016-03-10  1200  		return (u32)-EOPNOTSUPP;
6bc0ce7d Salil      2015-12-03  1201  	}
6bc0ce7d Salil      2015-12-03  1202  
6bc0ce7d Salil      2015-12-03  1203  	ops = priv->ae_handle->dev->ops;
6bc0ce7d Salil      2015-12-03  1204  	ret = ops->get_rss_indir_size(priv->ae_handle);
6bc0ce7d Salil      2015-12-03  1205  
6bc0ce7d Salil      2015-12-03  1206  	return ret;
6bc0ce7d Salil      2015-12-03  1207  }
6bc0ce7d Salil      2015-12-03  1208  
6bc0ce7d Salil      2015-12-03  1209  static int
6bc0ce7d Salil      2015-12-03  1210  hns_get_rss(struct net_device *netdev, u32 *indir, u8 *key, u8 *hfunc)
6bc0ce7d Salil      2015-12-03  1211  {
6bc0ce7d Salil      2015-12-03  1212  	struct hns_nic_priv *priv = netdev_priv(netdev);
6bc0ce7d Salil      2015-12-03  1213  	struct hnae_ae_ops *ops;
6bc0ce7d Salil      2015-12-03 @1214  	int ret;
6bc0ce7d Salil      2015-12-03  1215  
6bc0ce7d Salil      2015-12-03  1216  	if (AE_IS_VER1(priv->enet_ver)) {
6bc0ce7d Salil      2015-12-03  1217  		netdev_err(netdev,
6bc0ce7d Salil      2015-12-03  1218  			   "RSS feature is not supported on this hardware\n");
6bc0ce7d Salil      2015-12-03  1219  		return -EOPNOTSUPP;
6bc0ce7d Salil      2015-12-03  1220  	}
6bc0ce7d Salil      2015-12-03  1221  
6bc0ce7d Salil      2015-12-03  1222  	ops = priv->ae_handle->dev->ops;

:::::: The code at line 1214 was first introduced by commit
:::::: 6bc0ce7d9adabf332afc102f7f97bf121b990ece net:hns: Add Hip06 "RSS(Receive Side Scaling)" support to HNS Driver

:::::: TO: Salil <salil.mehta@huawei.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 52478 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160310/b8999330/attachment-0001.obj>
