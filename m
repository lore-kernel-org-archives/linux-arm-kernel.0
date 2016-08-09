From: robh@kernel.org (Rob Herring)
Date: Tue, 9 Aug 2016 12:35:55 -0500
Subject: [PATCH 2/2] ARM: imx6: mark GPC node as not populated after irq
 init to probe pm domain driver
In-Reply-To: <1470752332-14185-2-git-send-email-p.zabel@pengutronix.de>
References: <1470752332-14185-1-git-send-email-p.zabel@pengutronix.de>
 <1470752332-14185-2-git-send-email-p.zabel@pengutronix.de>
Message-ID: <20160809173555.GB11738@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 09, 2016 at 04:18:52PM +0200, Philipp Zabel wrote:
> Since IRQCHIP_DECLARE now flags the GPC node as already populated, the
> GPC power domain driver is never probed unless we clear the flag again.
> 
> Fixes: 15cc2ed6dcf9 ("of/irq: Mark initialised interrupt controllers as populated")
> Suggested-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> Cc: Jon Hunter <jonathanh@nvidia.com>
> ---
>  arch/arm/mach-imx/gpc.c | 6 ++++++
>  1 file changed, 6 insertions(+)

I've applied both patches.

Rob
