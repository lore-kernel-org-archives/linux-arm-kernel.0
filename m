From: tj@kernel.org (Tejun Heo)
Date: Tue, 17 Jun 2014 12:14:47 -0400
Subject: [PATCH 8/9] ata: Add support for the Tegra124 SATA controller
In-Reply-To: <20140617161320.GG31819@htj.dyndns.org>
References: <1401881559-18469-1-git-send-email-mperttunen@nvidia.com>
 <1401881559-18469-9-git-send-email-mperttunen@nvidia.com>
 <1470404.13mIFv0Hnj@amdc1032> <53A0686F.4000303@wwwdotorg.org>
 <20140617161320.GG31819@htj.dyndns.org>
Message-ID: <20140617161447.GH31819@htj.dyndns.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 17, 2014 at 12:13:20PM -0400, Tejun Heo wrote:
> On Tue, Jun 17, 2014 at 10:10:23AM -0600, Stephen Warren wrote:
> > > sata_writel() and sata_read() static inlines don't seem to add any value.
> > > 
> > > Can they be removed?
> > 
> > Such functions are quite idiomatic in drivers, and serve to simplify all
> > the call-sites by removing the need to write out the addition of the
> > base address everywhere.
> 
> I think it obfuscates more than helps.  If you absoluately have to
> keep it, please at least name it so that it's clear that it's
> something specific to this driver.

Please also drop inline.  It isn't a difficult optimization to perform
for the compiler.

-- 
tejun
