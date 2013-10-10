From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Thu, 10 Oct 2013 14:00:32 +0300
Subject: [PATCH 2/5] clk: tegra: Add periph regs bank X
In-Reply-To: <20131010104306.GB6735@ulmo.nvidia.com>
References: <1380878014-22088-1-git-send-email-pdeschrijver@nvidia.com>
 <1380878014-22088-3-git-send-email-pdeschrijver@nvidia.com>
 <20131010104306.GB6735@ulmo.nvidia.com>
Message-ID: <20131010110032.GR4233@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 10, 2013 at 12:43:07PM +0200, Thierry Reding wrote:
> * PGP Signed by an unknown key
> 
> On Fri, Oct 04, 2013 at 12:12:41PM +0300, Peter De Schrijver wrote:
> > Tegra124 has an extra bank of peripheral clock registers. Add it to the
> > generic peripheral clock code.
> > 
> > Signed-off-by: Peter De Schrijver <pdeschrijver@nvidia.com>
> > ---
> >  drivers/clk/tegra/clk.c |   10 ++++++++++
> >  1 files changed, 10 insertions(+), 0 deletions(-)
> > 
> > diff --git a/drivers/clk/tegra/clk.c b/drivers/clk/tegra/clk.c
> > index c8c84ce..0240dc3 100644
> > --- a/drivers/clk/tegra/clk.c
> > +++ b/drivers/clk/tegra/clk.c
> > @@ -57,6 +57,8 @@
> >  #define RST_DEVICES_CLR_V		0x434
> >  #define RST_DEVICES_SET_W		0x438
> >  #define RST_DEVICES_CLR_W		0x43c
> > +#define RST_DEVICES_SET_X		0x290
> > +#define RST_DEVICES_CLR_X		0x294
> 
> Perhaps sort these numerically rather than alphabetically? Also I don't

Why? I think alphabetically makes more sense or possibly per bank.

> see where the CLK_OUT_ENB_X, CLK_OUT_ENB_{SET,CLR}_X or RST_DEVICES_X
> registers are defined. Perhaps they were part of some other patch or a
> series that this depends on?
> 

Cheers,

Peter.
