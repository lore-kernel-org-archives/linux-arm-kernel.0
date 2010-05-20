From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Thu, 20 May 2010 11:33:30 +0200
Subject: [PATCH] ARM: Samsung: Add platform support code for OneNAND
	controller
In-Reply-To: <20100520084848.GO4720@trinity.fluff.org>
References: <1274338745-1745-1-git-send-email-m.szyprowski@samsung.com>
	<20100520084848.GO4720@trinity.fluff.org>
Message-ID: <014f01caf7ff$84d456f0$8e7d04d0$%szyprowski@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thursday, May 20, 2010 10:49 AM Ben Dooks wrote:

> On Thu, May 20, 2010 at 08:59:05AM +0200, Marek Szyprowski wrote:
> > This patch adds setup code for Samsung OneNAND controller driver. The
> > driver needs to be aware on which SoC it is running, so the actual
> > device id is being changed in cpu init code. S3C64xx SoCs have 2 OneNAND
> > controllers while S5PC100 and S5PC110 has only one.
> >
> > Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
> > Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
> 
> Ok, in future please try and keep a core and then have the architecture
> additions seperate, it makes it very difficult to deal with any problems
> whilst merging and means there is a higher possibility of a problem during
> this.

Ok, but I'm still not 100% sure how should I handle case like this properly.
I thought that separating platform files from the driver itself would help
merging it, because each part (the driver and platform setup code/register
definitions) can be merged separately by the respective maintainers. Was it
wrong that the platform patch was prepared for the tree after plat-s5pc1xx
moves? 

Best regards
-- 
Marek Szyprowski
Samsung Poland R&D Center
