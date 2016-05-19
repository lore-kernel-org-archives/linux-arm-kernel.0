From: tony@atomide.com (Tony Lindgren)
Date: Thu, 19 May 2016 07:57:46 -0700
Subject: [RFC PATCH 2/3] mmc: host: omap_hsmmc: Enable ADMA2
In-Reply-To: <0d463add-9fa5-a768-2ba6-34c4126c7817@ti.com>
References: <1463561115-31798-1-git-send-email-kishon@ti.com>
 <1463561115-31798-3-git-send-email-kishon@ti.com>
 <b66f678a-be74-d5f7-f2ef-93b5c9f29b92@ti.com>
 <20160518193028.GT5995@atomide.com>
 <0d463add-9fa5-a768-2ba6-34c4126c7817@ti.com>
Message-ID: <20160519145745.GU5995@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Peter Ujfalusi <peter.ujfalusi@ti.com> [160519 01:10]:
> On 05/18/2016 10:30 PM, Tony Lindgren wrote:
> > Ideally the adma support would be a separate loadable module,
> > similar how the cppi41dma is a child of the OTG controller.
> 
> The Master DMA is part of the hsmmc IP block. If the same ADMA module is
> present on other IPs it might be beneficial to have a helper library to handle
> it (allocating the descriptor pool, wrinting, updating descriptors, etc).

OK. Yeah if it's part of the MMC controller it makes no sense to
separate it. So then the conecrns are using alternate DMA
implementations and keeping PM runtime working :)

BTW, Felipe mentioned that the best thing to do in the long run would
be to set up sdhci-omap.c operating in ADMA mode.

Felipe, care to summarize what you had in mind?

Regards,

Tony
