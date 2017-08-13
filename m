From: lkp@intel.com (kbuild test robot)
Date: Sun, 13 Aug 2017 08:44:19 +0800
Subject: [PATCH v7] rockchip/rga: v4l2 m2m support
In-Reply-To: <1501737812-24171-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <201708130829.Loc08RDM%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

[auto build test ERROR on rockchip/for-next]
[also build test ERROR on v4.13-rc4 next-20170811]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/rockchip-rga-v4l2-m2m-support/20170803-234713
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
config: openrisc-allyesconfig (attached as .config)
compiler: or1k-linux-gcc (GCC) 5.4.0
reproduce:
        wget https://raw.githubusercontent.com/01org/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # save the attached .config to linux build tree
        make.cross ARCH=openrisc 

All errors (new ones prefixed by >>):

   drivers/media/platform/rockchip-rga/rga.c: In function 'rga_s_ctrl':
>> drivers/media/platform/rockchip-rga/rga.c:159:7: error: 'V4L2_CID_PORTER_DUFF_MODE' undeclared (first use in this function)
     case V4L2_CID_PORTER_DUFF_MODE:
          ^
   drivers/media/platform/rockchip-rga/rga.c:159:7: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/platform/rockchip-rga/rga.c: In function 'rga_setup_ctrls':
   drivers/media/platform/rockchip-rga/rga.c:190:11: error: 'V4L2_CID_PORTER_DUFF_MODE' undeclared (first use in this function)
              V4L2_CID_PORTER_DUFF_MODE,
              ^
   drivers/media/platform/rockchip-rga/rga.c:191:11: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
              V4L2_PORTER_DUFF_CLEAR, 0,
              ^
   drivers/media/platform/rockchip-rga/rga.c:192:11: error: 'V4L2_PORTER_DUFF_SRC' undeclared (first use in this function)
              V4L2_PORTER_DUFF_SRC);
              ^
   drivers/media/platform/rockchip-rga/rga.c: At top level:
   drivers/media/platform/rockchip-rga/rga.c:742:12: warning: 'rga_enable_clocks' defined but not used [-Wunused-function]
    static int rga_enable_clocks(struct rockchip_rga *rga)
               ^
   drivers/media/platform/rockchip-rga/rga.c:774:13: warning: 'rga_disable_clocks' defined but not used [-Wunused-function]
    static void rga_disable_clocks(struct rockchip_rga *rga)
                ^
--
   drivers/media/platform/rockchip-rga/rga-hw.c: In function 'rga_cmd_set_trans_info':
   drivers/media/platform/rockchip-rga/rga-hw.c:237:17: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
     if (ctx->op == V4L2_PORTER_DUFF_CLEAR) {
                    ^
   drivers/media/platform/rockchip-rga/rga-hw.c:237:17: note: each undeclared identifier is reported only once for each function it appears in
   drivers/media/platform/rockchip-rga/rga-hw.c: In function 'rga_cmd_set_mode':
   drivers/media/platform/rockchip-rga/rga-hw.c:391:7: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_CLEAR:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c:397:7: error: 'V4L2_PORTER_DUFF_DST' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DST:
          ^
>> drivers/media/platform/rockchip-rga/rga-hw.c:398:7: error: 'V4L2_PORTER_DUFF_DSTATOP' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTATOP:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c:399:7: error: 'V4L2_PORTER_DUFF_DSTIN' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTIN:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c:400:7: error: 'V4L2_PORTER_DUFF_DSTOUT' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTOUT:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c:401:7: error: 'V4L2_PORTER_DUFF_DSTOVER' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_DSTOVER:
          ^
>> drivers/media/platform/rockchip-rga/rga-hw.c:402:7: error: 'V4L2_PORTER_DUFF_SRCATOP' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCATOP:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c:403:7: error: 'V4L2_PORTER_DUFF_SRCIN' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCIN:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c:404:7: error: 'V4L2_PORTER_DUFF_SRCOUT' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCOUT:
          ^
>> drivers/media/platform/rockchip-rga/rga-hw.c:405:7: error: 'V4L2_PORTER_DUFF_SRCOVER' undeclared (first use in this function)
     case V4L2_PORTER_DUFF_SRCOVER:
          ^
   drivers/media/platform/rockchip-rga/rga-hw.c: In function 'rga_cmd_set':
   drivers/media/platform/rockchip-rga/rga-hw.c:623:17: error: 'V4L2_PORTER_DUFF_CLEAR' undeclared (first use in this function)
     if (ctx->op != V4L2_PORTER_DUFF_CLEAR) {
                    ^

vim +/V4L2_CID_PORTER_DUFF_MODE +159 drivers/media/platform/rockchip-rga/rga.c

   150	
   151	static int rga_s_ctrl(struct v4l2_ctrl *ctrl)
   152	{
   153		struct rga_ctx *ctx = container_of(ctrl->handler, struct rga_ctx,
   154						   ctrl_handler);
   155		unsigned long flags;
   156	
   157		spin_lock_irqsave(&ctx->rga->ctrl_lock, flags);
   158		switch (ctrl->id) {
 > 159		case V4L2_CID_PORTER_DUFF_MODE:
   160			ctx->op = ctrl->val;
   161			break;
   162		case V4L2_CID_HFLIP:
   163			ctx->hflip = ctrl->val;
   164			break;
   165		case V4L2_CID_VFLIP:
   166			ctx->vflip = ctrl->val;
   167			break;
   168		case V4L2_CID_ROTATE:
   169			ctx->rotate = ctrl->val;
   170			break;
   171		case V4L2_CID_BG_COLOR:
   172			ctx->fill_color = ctrl->val;
   173			break;
   174		}
   175		spin_unlock_irqrestore(&ctx->rga->ctrl_lock, flags);
   176		return 0;
   177	}
   178	

---
0-DAY kernel test infrastructure                Open Source Technology Center
https://lists.01.org/pipermail/kbuild-all                   Intel Corporation
-------------- next part --------------
A non-text attachment was scrubbed...
Name: .config.gz
Type: application/gzip
Size: 42497 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170813/4d40a474/attachment-0001.gz>
