From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 02 Jan 2013 15:06:11 -0700
Subject: [PATCH v2 09/11] clk: tegra: add dt support
In-Reply-To: <1356619644-18565-10-git-send-email-pgaikwad@nvidia.com>
References: <1356619644-18565-1-git-send-email-pgaikwad@nvidia.com>
 <1356619644-18565-10-git-send-email-pgaikwad@nvidia.com>
Message-ID: <50E4AF53.2000905@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/27/2012 07:47 AM, Prashant Gaikwad wrote:
> Add support to initialize clock from DT.

Rather than require every separate clock driver to create a header in
include/linux/clk/$socname.h, would it make sense to create a single
function that can initialize any enable SoC's clocks, using a scheme
similar to:

https://lkml.org/lkml/2012/11/20/706

That's in linux-next as of today, and Thomas Petazzoni was working on
something similar for irqchips. It probably wouldn't be too hard to do
the same for clock initialization?
