From: lkp@intel.com (kbuild test robot)
Date: Thu, 11 Aug 2016 10:45:41 +0800
Subject: [PATCH 11/21] net: thunderx: Add support for 16 LMACs of 83xx
In-Reply-To: <1470811373-28277-12-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <201608111032.1Q3MCxhS%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sunil,

[auto build test ERROR on net-next/master]
[also build test ERROR on v4.8-rc1 next-20160809]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/sunil-kovvuri-gmail-com/net-thunderx-Support-for-newer-chips-and-miscellaneous-patches/20160811-051837
config: x86_64-allmodconfig (attached as .config)
compiler: gcc-6 (Debian 6.1.1-9) 6.1.1 20160705
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

Note: the linux-review/sunil-kovvuri-gmail-com/net-thunderx-Support-for-newer-chips-and-miscellaneous-patches/20160811-051837 HEAD 5dcb590bc5f427045688ce0ace2e3d39d22e979f builds fine.
      It only hurts bisectibility.

All errors (new ones prefixed by >>):

   drivers/net/ethernet/cavium/thunder/nic_main.c: In function 'nic_mbx_send_ready':
>> drivers/net/ethernet/cavium/thunder/nic_main.c:177:11: error: 'MAX_LMAC' undeclared (first use in this function)
     if (vf < MAX_LMAC) {
              ^~~~~~~~
   drivers/net/ethernet/cavium/thunder/nic_main.c:177:11: note: each undeclared identifier is reported only once for each function it appears in

vim +/MAX_LMAC +177 drivers/net/ethernet/cavium/thunder/nic_main.c

4863dea3 Sunil Goutham 2015-05-26  171  
4863dea3 Sunil Goutham 2015-05-26  172  	mbx.nic_cfg.msg = NIC_MBOX_MSG_READY;
4863dea3 Sunil Goutham 2015-05-26  173  	mbx.nic_cfg.vf_id = vf;
4863dea3 Sunil Goutham 2015-05-26  174  
4863dea3 Sunil Goutham 2015-05-26  175  	mbx.nic_cfg.tns_mode = NIC_TNS_BYPASS_MODE;
4863dea3 Sunil Goutham 2015-05-26  176  
92dc8769 Sunil Goutham 2015-08-30 @177  	if (vf < MAX_LMAC) {
4863dea3 Sunil Goutham 2015-05-26  178  		bgx_idx = NIC_GET_BGX_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
4863dea3 Sunil Goutham 2015-05-26  179  		lmac = NIC_GET_LMAC_FROM_VF_LMAC_MAP(nic->vf_lmac_map[vf]);
4863dea3 Sunil Goutham 2015-05-26  180  

:::::: The code at line 177 was first introduced by commit
:::::: 92dc87697e6a71675a9e9eec04ebecd8cf4837a3 net: thunderx: Support for upto 96 queues for a VF

:::::: TO: Sunil Goutham <sgoutham@cavium.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/octet-stream
Size: 55455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160811/73cb69bf/attachment-0001.obj>
