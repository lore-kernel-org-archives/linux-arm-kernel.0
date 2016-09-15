From: vinod.koul@intel.com (Vinod Koul)
Date: Thu, 15 Sep 2016 21:54:49 +0530
Subject: [PATCH] ARM: s3c24xx: Add dma_slave_map for s3c2440 devices
In-Reply-To: <2fa402bf-0e3f-0495-41ca-7a3c89eaa2e1@samsung.com>
References: <CGME20160914183040eucas1p22a61e6b39333cfe1aa9a6b63e74a1bcf@eucas1p2.samsung.com>
 <1473877775-7537-1-git-send-email-sam.van.den.berge@telenet.be>
 <2fa402bf-0e3f-0495-41ca-7a3c89eaa2e1@samsung.com>
Message-ID: <20160915162449.GY13920@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 15, 2016 at 11:05:12AM +0200, Sylwester Nawrocki wrote:
> On 09/14/2016 08:29 PM, Sam Van Den Berge wrote:
> > +static const struct dma_slave_map s3c2440_dma_slave_map[] = {
> ...
> > +	{ "3c2440-sdi", "rx", (void *)DMACH_SDI },
> > +	{ "3c2440-sdi", "tx", (void *)DMACH_SDI },
> 
> The device names seem misspelled here, and looking at what
> drivers/mmc/host/s3cmci.c driver does we need just a single common
> entry for rx and tx
> 
> 	{ "s3c2440-sdi", "rx-tx", (void *)DMACH_SDI },
> 
> With this fixed feel free to add

And please change the title to dmaengine and NOT arm... I was about ti skip
this!

-- 
~Vinod
