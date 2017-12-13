From: fengguang.wu@intel.com (kbuild test robot)
Date: Wed, 13 Dec 2017 23:22:36 +0800
Subject: [xlnx:2017.3_video_ea 6599/6607]
 drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp1x_rx.c:896:22: warning: ')
 - ' directive output may be truncated writing 4 bytes into a region of size
 between 3 and 7
Message-ID: <201712132325.rtsq4jLG%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

tree:   https://github.com/Xilinx/linux-xlnx 2017.3_video_ea
head:   af045f9682c65a0c26afb2f638603d3c01079222
commit: 15c99dce11944aa6657cade4fb30d978d002e783 [6599/6607] staging: xilinx: hdmirx: Fix hdcp authentication problem on key load
config: blackfin-allmodconfig (attached as .config)
compiler: bfin-uclinux-gcc (GCC) 7.2.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout 15c99dce11944aa6657cade4fb30d978d002e783
        # save the attached .config to linux build tree
        make.cross ARCH=blackfin 

All warnings (new ones prefixed by >>):

   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp1x_rx.c: In function 'XHdcp1x_RxDebugLog.isra.6':
>> drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp1x_rx.c:896:22: warning: ') - ' directive output may be truncated writing 4 bytes into a region of size between 3 and 7 [-Wformat-truncation=]
     snprintf(Label, 16, "hdcp-rx(%d) - ", InstancePtr->Config.DeviceId);
                         ^~~~~~~~~~~~~~~~
   drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp1x_rx.c:896:2: note: 'snprintf' output between 14 and 18 bytes into a destination of size 16
     snprintf(Label, 16, "hdcp-rx(%d) - ", InstancePtr->Config.DeviceId);
     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +896 drivers/staging/xilinx/hdmi/phy-xilinx-vphy/xhdcp1x_rx.c

73634d89 Rohit Consul 2017-10-31  878  
73634d89 Rohit Consul 2017-10-31  879  /*****************************************************************************/
73634d89 Rohit Consul 2017-10-31  880  /**
73634d89 Rohit Consul 2017-10-31  881  * This function logs a debug message on behalf of a handler state machine.
73634d89 Rohit Consul 2017-10-31  882  *
73634d89 Rohit Consul 2017-10-31  883  * @param	InstancePtr is the receiver instance.
73634d89 Rohit Consul 2017-10-31  884  * @param	LogMsg is the message to log.
73634d89 Rohit Consul 2017-10-31  885  *
73634d89 Rohit Consul 2017-10-31  886  * @return	None.
73634d89 Rohit Consul 2017-10-31  887  *
73634d89 Rohit Consul 2017-10-31  888  * @note		None.
73634d89 Rohit Consul 2017-10-31  889  *
73634d89 Rohit Consul 2017-10-31  890  ******************************************************************************/
73634d89 Rohit Consul 2017-10-31  891  static void XHdcp1x_RxDebugLog(const XHdcp1x *InstancePtr, const char *LogMsg)
73634d89 Rohit Consul 2017-10-31  892  {
73634d89 Rohit Consul 2017-10-31  893  	char Label[16];
73634d89 Rohit Consul 2017-10-31  894  
73634d89 Rohit Consul 2017-10-31  895  	/* Format Label */
73634d89 Rohit Consul 2017-10-31 @896  	snprintf(Label, 16, "hdcp-rx(%d) - ", InstancePtr->Config.DeviceId);
73634d89 Rohit Consul 2017-10-31  897  
73634d89 Rohit Consul 2017-10-31  898  	/* Log it */
73634d89 Rohit Consul 2017-10-31  899  	XHDCP1X_DEBUG_LOGMSG(Label);
73634d89 Rohit Consul 2017-10-31  900  	XHDCP1X_DEBUG_LOGMSG(LogMsg);
15c99dce Rohit Consul 2017-11-14  901  	XHDCP1X_DEBUG_LOGMSG("\n");
73634d89 Rohit Consul 2017-10-31  902  }
73634d89 Rohit Consul 2017-10-31  903  

:::::: The code at line 896 was first introduced by commit
:::::: 73634d891211ef92c9d8c789a1ccc002118164ba phy: xilinx-vphy: Initial release of xilinx video phy soft IP driver

:::::: TO: Rohit Consul <rohit.consul@xilinx.com>
:::::: CC: Jeffrey Mouroux <jmouroux@xilinx.com>

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42262 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171213/1acd4476/attachment-0001.gz>
