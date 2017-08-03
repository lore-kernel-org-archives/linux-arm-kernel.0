From: lkp@intel.com (kbuild test robot)
Date: Thu, 3 Aug 2017 22:25:12 +0800
Subject: [PATCH v6] rockchip/rga: v4l2 m2m support
In-Reply-To: <1501668050-31618-1-git-send-email-jacob-chen@iotwrt.com>
Message-ID: <201708032210.34IGlPCJ%fengguang.wu@intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jacob,

[auto build test WARNING on rockchip/for-next]
[also build test WARNING on v4.13-rc3 next-20170803]
[if your patch is applied to the wrong git tree, please drop us a note to help improve the system]

url:    https://github.com/0day-ci/linux/commits/Jacob-Chen/rockchip-rga-v4l2-m2m-support/20170802-235943
base:   https://git.kernel.org/pub/scm/linux/kernel/git/mmind/linux-rockchip.git for-next
reproduce:
        # apt-get install sparse
        make ARCH=x86_64 allmodconfig
        make C=1 CF=-D__CHECK_ENDIAN__


sparse warnings: (new ones prefixed by >>)


vim +/case +159 drivers/media/platform/rockchip-rga/rga.c

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
