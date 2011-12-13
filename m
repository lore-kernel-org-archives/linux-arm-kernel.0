From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 13 Dec 2011 15:16:26 -0700 (MST)
Subject: [PATCHv11 2/8] ARM: OMAP2+: hwmod: Add API to check IO PAD wakeup
 status
In-Reply-To: <1323713733-13115-3-git-send-email-t-kristo@ti.com>
References: <1323713733-13115-1-git-send-email-t-kristo@ti.com>
 <1323713733-13115-3-git-send-email-t-kristo@ti.com>
Message-ID: <alpine.DEB.2.00.1112131505000.12046@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

a question

On Mon, 12 Dec 2011, Tero Kristo wrote:

So the patch description says:

> From: R, Govindraj <govindraj.raja@ti.com>
> 
> Add API to determine IO-PAD wakeup event status for a given
> hwmod dynamic_mux pad.

But the code does:

> +	for (i = 0; i < hmux->nr_pads; i++) {
> +		struct omap_device_pad *pad = &hmux->pads[i];

which is going to check all of the pads, not just the dynamic ones.

So it seems to me that we need to decide whether this code should be 
testing all the pads, or just the dynamically remuxed ones.  The same 
thing should be decided for the code in patch 1.

Na?vely it seems to me that we want to test all of the pads in both 
patches 1 and 2, not just the dynamically remuxable ones.  Comments?


- Paul
