From: eric@eukrea.com (Eric =?ISO-8859-1?B?QuluYXJk?=)
Date: Tue, 27 Mar 2012 11:06:15 +0200
Subject: [MX25][MMC] mmc esdhc failure in 3.3
In-Reply-To: <20120327090148.GB6790@pengutronix.de>
References: <5e57eb999780335721212bb8d411406f@mail.fqingenieria.es>
 <20120312132423.GC2459@pengutronix.de>
 <9018463dfcd3c9e9a311aeed42b758bf@mail.fqingenieria.es>
 <0E83723C55F66F43A6041464FE31119D099A34@039-SN2MPN1-011.039d.mgd.msft.net>
 <a06e68c3687c7390e15950bc20831fd4@mail.fqingenieria.es>
 <85b807b77d73328485781d6fa1568e46@mail.fqingenieria.es>
 <20120327101259.73525f9d@eb-e6520>
 <ac05d6e5c1ce4bf9cfc5c28d235f866f@mail.fqingenieria.es>
 <20120327090148.GB6790@pengutronix.de>
Message-ID: <20120327110615.3bfaf969@eb-e6520>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wolfram,

Le Tue, 27 Mar 2012 11:01:49 +0200,
Wolfram Sang <w.sang@pengutronix.de> a ?crit :
> > >does that attached patch fix your problem ?
> > 
> > YES, indeed it does to a certain degree. The timeout errors do not
> > occur anymore and I can successfully perform many fs->ops, such as
> 
> Interesting question is now why it worked on your older kernel? The code
> around BROKEN_TIMEOUT is there for much longer, I'd think.
> 
not in fact it seems to have been broken from a long time and I think
I'm responsible of that in 37865fe91582582a6f6c00652f6a2b1ff71f8a78
"mmc: sdhci-esdhc-imx: fix timeout on i.MX's sdhc"
because unlike the i.MX35 it seems that the i.MX25 manages to read
properly the partition table even without the timeout quirk and it
seems that I didn't do more extensive tests for this patch.

Eric
