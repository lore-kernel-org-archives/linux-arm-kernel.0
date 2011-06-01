From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Wed, 1 Jun 2011 07:17:53 +0200
Subject: [PATCH 1/3] [v2] davinci: sram: ioremap the davinci_soc_info
	specified sram regions
In-Reply-To: <3406118d1598e5e279108dd94c63ced1fa8d02bc.1306877621.git.bengardiner@nanometrics.ca>
References: <cover.1306877621.git.bengardiner@nanometrics.ca>
	<3406118d1598e5e279108dd94c63ced1fa8d02bc.1306877621.git.bengardiner@nanometrics.ca>
Message-ID: <20110601051753.GA5153@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17:46 Tue 31 May     , Ben Gardiner wrote:
> The current davinci init sets up SRAM in iotables. There has been an observed
> failure to boot a da850 with 128K specified in the iotable.
> 
> Make the davinci sram allocator -- now based on RMK's consolidated SRAM
> support -- do an ioremap of the region specified by the entries in
> davinci_soc_info before registering with pv_pool_create().
you should update the commit message
> 
> This commit breaks runtime of davinci boards since the regions that
> the sram init is now trying to ioremap have been iomapped by their
> iotable entries. The iotable entries will be removed in the patches
> to come.
> 
> Signed-off-by: Ben Gardiner <bengardiner@nanometrics.ca>
> CC: Sekhar Nori <nsekhar@ti.com>
> 
> ---
> Changes since v1:
>  * return -ENOMEM if ioremap fails (Sekhar Nori)
you need to put your sob

otherwise 

Acked-by: Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>

for the whole series

Best Regards,
J.
