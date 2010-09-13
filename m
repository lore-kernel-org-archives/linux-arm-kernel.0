From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 13 Sep 2010 15:50:05 +0200
Subject: [PATCH 5/5] mfd: fix max8925 irq control bit incorrect setting
In-Reply-To: <1283953476-2395-5-git-send-email-haojian.zhuang@marvell.com>
References: <1283953476-2395-1-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-2-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-3-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-4-git-send-email-haojian.zhuang@marvell.com>
	<1283953476-2395-5-git-send-email-haojian.zhuang@marvell.com>
Message-ID: <20100913135004.GG2555@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Haojian,

On Wed, Sep 08, 2010 at 09:44:36AM -0400, Haojian Zhuang wrote:
> From: Kevin Liu <kliu5@marvell.com>
> 
> In max8925_irq_sync_unlock(), irq control bit is set at the same time.
> Zero means enabling irq, and one means disabling irq.
> 
> The original code is:
> 	irq_chg[0] &= irq_data->enable;
> 
> It should be changed to:
> 	irq_chg[0] &= ~irq_data->enable;
> 
> Otherwise, irq control bit is mess.
Ok, patch applied as well, thanks.
I am going to send this one for 2.6.36 inclusion.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
