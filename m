From: chaotian.jing@mediatek.com (chaotian.jing)
Date: Sun, 19 Apr 2015 11:22:41 +0800
Subject: [PATCH v2 2/5] mmc: mediatek: Add Mediatek MMC driver
In-Reply-To: <20150417134547.GN4946@pengutronix.de>
References: <1426562035-16709-1-git-send-email-chaotian.jing@mediatek.com>
 <1426562035-16709-3-git-send-email-chaotian.jing@mediatek.com>
 <20150417134547.GN4946@pengutronix.de>
Message-ID: <1429413761.16027.2.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sascha,


On Fri, 2015-04-17 at 15:45 +0200, Sascha Hauer wrote:
> Hi Chaotian,
> 
> On Tue, Mar 17, 2015 at 11:13:52AM +0800, Chaotian Jing wrote:
> > Add Mediatek MMC driver code
> > 
> 
> [...]
> 
> > +	host->dev = &pdev->dev;
> > +	host->mmc = mmc;
> > +	/* Set host parameters to mmc */
> > +	mmc->ops = &mt_msdc_ops;
> > +	mmc->f_min = 260000;
> > +	mmc->ocr_avail = MMC_VDD_30_31 | MMC_VDD_31_32 | MMC_VDD_32_33;
> > +
> > +	mmc->caps |= MMC_CAP_ERASE | MMC_CAP_CMD23;
> > +	/* MMC core transfer sizes tunable parameters */
> > +	mmc->max_segs = MAX_BD_NUM;
> > +	mmc->max_seg_size = 64 * 1024;
> 
> Earlier versions of this driver had 64 * 1024 - 512 here. Using 64k
> breaks SD card support here. Reading the partition table still works
> fine, but the next transfers fail with messages like:
> 
> mtk-msdc 11240000.mmc: msdc_request_timeout: aborting cmd/data/mrq
> mtk-msdc 11240000.mmc: msdc_request_timeout: aborting mrq=ffffffc06e586860 cmd=18
> mtk-msdc 11240000.mmc: msdc_request_timeout: abort data: cmd18; 136 blocks
> mmcblk1: error -110 transferring data, sector 338488, nr 136, cmd response 0x900, card status 0xb00
> mtk-msdc 11240000.mmc: set mclk to 0 mmc1: tried to reset card
> 
> Can you confirm this?
> 
Yes, it will be fixed at next revision.
Thx!
> Sascha
> 
