From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 9 Apr 2015 08:28:26 -0700
Subject: [PATCH 4/8] clk: tegra: Fix duplicate const for parent names
In-Reply-To: <20150409101947.GM12103@ulmo>
References: <1428499339-29569-1-git-send-email-k.kozlowski@samsung.com>
 <1428499339-29569-5-git-send-email-k.kozlowski@samsung.com>
 <20150409100036.GK12103@ulmo>
 <CAJKOXPd4KsZ-pLDUtyWwyJviZyFWQKVLTVpW_6_Yye2o=3xy0g@mail.gmail.com>
 <20150409101947.GM12103@ulmo>
Message-ID: <20150409152826.GB18835@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/09, Thierry Reding wrote:
> On Thu, Apr 09, 2015 at 12:07:59PM +0200, Krzysztof Kozlowski wrote:
> > 2015-04-09 12:00 GMT+02:00 Thierry Reding <thierry.reding@gmail.com>:
> > > On Wed, Apr 08, 2015 at 03:22:15PM +0200, Krzysztof Kozlowski wrote:
> > >> Replace duplicated const keyword for 'emc_parent_clk_names' with proper
> > >> array of const pointers to const strings.
> > >>
> > >> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> > >> ---
> > >>  drivers/clk/tegra/clk-emc.c | 2 +-
> > >>  1 file changed, 1 insertion(+), 1 deletion(-)
> > >
> > > This would probably better go in via the Tegra tree since the patch that
> > > contains this has only made it to linux-next.
> > >
> > > Stephen, Mike, any objections to me taking this?
> > 
> > Applying this without the change for const-ness of parent_names (patch
> > by Sascha Hauer sent before mine [1]) would introduce a warning -
> > assign of const to non-const. Any idea to solve it? Immutable branch?
> 
> Right, I had missed that. Immutable branch would work, though perhaps
> it'd be easier to just defer this until after v4.1-rc1. The warning
> shouldn't happen if we leave out this single patch and apply it later
> on, right?
> 
> Alternatively the whole series could be deferred until after v4.1-rc1.
> 

Yeah I don't really care to make an immutable branch for this
cleanup series. If everyone is ok with waiting until after -rc1
we can apply the Tegra patch then (or you can and we'll get it
through a pull later). We should be able to apply the parts that
go through clk tree though.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
