From: lkp@intel.com (kbuild test robot)
Date: Wed, 3 Feb 2016 17:11:54 +0800
Subject: [PATCH net-next 2/4] drivers: net: xgene: Add support for RSS
In-Reply-To: <1454486116-23783-3-git-send-email-isubramanian@apm.com>
Message-ID: <201602031717.9mguWR0W%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Iyappan,

[auto build test WARNING on net-next/master]

url:    https://github.com/0day-ci/linux/commits/Iyappan-Subramanian/Add-support-for-Classifier-and-RSS/20160203-155838
config: i386-allmodconfig (attached as .config)
reproduce:
        # save the attached .config to linux build tree
        make ARCH=i386 

All warnings (new ones prefixed by >>):

   drivers/net/ethernet/apm/xgene/xgene_enet_cle.c: In function 'xgene_enet_cle_init':
>> drivers/net/ethernet/apm/xgene/xgene_enet_cle.c:729:1: warning: the frame size of 1096 bytes is larger than 1024 bytes [-Wframe-larger-than=]
    }
    ^

vim +729 drivers/net/ethernet/apm/xgene/xgene_enet_cle.c

bdc3a65f Iyappan Subramanian 2016-02-02  713  	dbptr[DB_RES_DROP].drop = 1;
bdc3a65f Iyappan Subramanian 2016-02-02  714  
bdc3a65f Iyappan Subramanian 2016-02-02  715  	memset(&kn, 0, sizeof(kn));
bdc3a65f Iyappan Subramanian 2016-02-02  716  	kn.node_type = KN;
bdc3a65f Iyappan Subramanian 2016-02-02  717  	kn.num_keys = 1;
bdc3a65f Iyappan Subramanian 2016-02-02  718  	kn.key[0].priority = 0;
bdc3a65f Iyappan Subramanian 2016-02-02  719  	kn.key[0].result_pointer = DB_RES_ACCEPT;
bdc3a65f Iyappan Subramanian 2016-02-02  720  
bdc3a65f Iyappan Subramanian 2016-02-02  721  	ptree->dn = ptree_dn;
bdc3a65f Iyappan Subramanian 2016-02-02  722  	ptree->kn = &kn;
bdc3a65f Iyappan Subramanian 2016-02-02  723  	ptree->dbptr = dbptr;
bdc3a65f Iyappan Subramanian 2016-02-02  724  	ptree->num_dn = MAX_NODES;
bdc3a65f Iyappan Subramanian 2016-02-02  725  	ptree->num_kn = 1;
bdc3a65f Iyappan Subramanian 2016-02-02  726  	ptree->num_dbptr = DB_MAX_PTRS;
bdc3a65f Iyappan Subramanian 2016-02-02  727  
bdc3a65f Iyappan Subramanian 2016-02-02  728  	return xgene_cle_setup_ptree(pdata, enet_cle);
bdc3a65f Iyappan Subramanian 2016-02-02 @729  }
bdc3a65f Iyappan Subramanian 2016-02-02  730  
bdc3a65f Iyappan Subramanian 2016-02-02  731  struct xgene_cle_ops xgene_cle3in_ops = {
bdc3a65f Iyappan Subramanian 2016-02-02  732  	.cle_init = xgene_enet_cle_init,
bdc3a65f Iyappan Subramanian 2016-02-02  733  };

:::::: The code at line 729 was first introduced by commit
:::::: bdc3a65fd7d47cc058cc913cfbd8f2934ef7f7a2 drivers: net: xgene: Add support for Classifier engine

:::::: TO: Iyappan Subramanian <isubramanian@apm.com>
:::::: CC: 0day robot <fengguang.wu@intel.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 53455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160203/5ee89788/attachment-0001.obj>
