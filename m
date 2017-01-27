From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 27 Jan 2017 22:26:11 +0100
Subject: [PATCH v4 10/13] arm64: allwinner: a64: Increase the MMC max
 frequency
In-Reply-To: <6c6bf169-4b2e-6b55-54db-d21da73a8f6e@heig-vd.ch>
References: <cover.8d42a39b7bd5143e709979dc42cc47862ebe3728.1485421557.git-series.maxime.ripard@free-electrons.com>
 <dee0dc8e1d98698231738b10fbe79cdf6d5e4c36.1485421557.git-series.maxime.ripard@free-electrons.com>
 <6c6bf169-4b2e-6b55-54db-d21da73a8f6e@heig-vd.ch>
Message-ID: <20170127212611.rn2nr4fihshud2qg@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 27, 2017 at 11:29:53AM +0100, Florian Vaussard wrote:
> Hi Maxime,
> 
> On 01/26/2017 10:06 AM, Maxime Ripard wrote:
> > The eMMC controller seem to have a maximum frequency of 200MHz, while the
> > regular MMC controllers are capped at 150MHz.
> > 
> > Since older SoCs cannot go that high, we cannot change the default maximum
> > frequency, but fortunately for us we have a property for that in the DT.
> > 
> > This also has the side effect of allowing to use the MMC HS200 and SD
> > SDR104 modes for the boards that support it (with either 1.2v or 1.8v IOs).
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > 
> > arm64: allwinner: a64: Limit MMC0 and MMC1 rates to 150MHz
> > 
> > Trying to set the bus to 200MHz on MMC1 when doing SDIO is failing.
> > Allwinner sets the maximum for this bus to 150MHz, so enforce that limit.
> > 
> > This hasn't been tested with MMC0, but the documented limit is the same,
> > and I expect the behaviour to be the same.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> I suspect that you are trying to increase your number of Signed-off-by tags by
> using unfair means :) Otherwise the squashed commit message is probably worth
> some cleaning.

/me hides in a corner...

The first commit log is the right one, I'll remove the second.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170127/75fffc2d/attachment-0001.sig>
