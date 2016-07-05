From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 05 Jul 2016 13:20:29 +0200
Subject: [PATCH 3/3] reset: socfpga: use readl/writel_relaxed
In-Reply-To: <1467713872-4051-3-git-send-email-p.zabel@pengutronix.de>
References: <1467713872-4051-1-git-send-email-p.zabel@pengutronix.de>
 <1467713872-4051-3-git-send-email-p.zabel@pengutronix.de>
Message-ID: <10266400.9nrl73J4sT@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 5, 2016 12:17:52 PM CEST Philipp Zabel wrote:
> This just removes the rmb()/wmb() pair between register read and
> write. Since no relevant reads follow the rmb and no relevant writes
> precede the wmb, they should be safe to remove.
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>

We should only do this if you are fixing a bug (which you don't mention
in the changelog), or if you can show a relevant performance
improvement. Is this code ever used in a fast path? If it is,
wouldn't that indicate a problem in some driver?

	Arnd
