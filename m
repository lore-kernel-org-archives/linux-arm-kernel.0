From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jan 2017 10:16:51 +0100
Subject: [PATCH v3 7/13] mmc: sunxi: Add more debug messages
In-Reply-To: <CAPDyKFqE7hMdwweE4zX4TcH5qCThb2_NQh5PNA_4coJQUrCwfg@mail.gmail.com>
References: <cover.a06ce1672d7a72ee7f9bbca46fdd223edd6b2313.1484585798.git-series.maxime.ripard@free-electrons.com>
 <102ea884b296dae38ab28369ce14aa7a7998dc80.1484585798.git-series.maxime.ripard@free-electrons.com>
 <CAPDyKFqE7hMdwweE4zX4TcH5qCThb2_NQh5PNA_4coJQUrCwfg@mail.gmail.com>
Message-ID: <20170125091651.pss4mokis4ncdkwf@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 24, 2017 at 09:22:24AM +0100, Ulf Hansson wrote:
> On 16 January 2017 at 17:56, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Add a bit more debug messages that can be helpful when debugging the clock
> > setup.
> >
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> > ---
> >  drivers/mmc/host/sunxi-mmc.c | 10 ++++++++--
> >  1 file changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sunxi-mmc.c b/drivers/mmc/host/sunxi-mmc.c
> > index f0f6922bca8a..40ed287ceb1c 100644
> > --- a/drivers/mmc/host/sunxi-mmc.c
> > +++ b/drivers/mmc/host/sunxi-mmc.c
> > @@ -661,6 +661,9 @@ static int sunxi_mmc_oclk_onoff(struct sunxi_mmc_host *host, u32 oclk_en)
> >         unsigned long expire = jiffies + msecs_to_jiffies(750);
> >         u32 rval;
> >
> > +       dev_dbg(mmc_dev(host->mmc), "%sabling the clock\n",
> > +               oclk_en ? "en" : "dis");
> > +
> >         rval = mmc_readl(host, REG_CLKCR);
> >         rval &= ~(SDXC_CARD_CLOCK_ON | SDXC_LOW_POWER_ON | SDXC_MASK_DATA0);
> >
> > @@ -737,6 +740,7 @@ static int sunxi_mmc_clk_set_phase(struct sunxi_mmc_host *host,
> >                         index = SDXC_CLK_50M_DDR;
> >                 }
> >         } else {
> > +               dev_dbg(mmc_dev(host->mmc), "Invalid clock... returning\n");
> >                 return -EINVAL;
> >         }
> >
> > @@ -753,6 +757,9 @@ static int sunxi_mmc_clk_set_rate(struct sunxi_mmc_host *host,
> >         u32 rval, clock = ios->clock;
> >         int ret;
> >
> > +       dev_dbg(mmc_dev(host->mmc), "setting clk to %u (requested %u)\n",
> > +               clock, ios->clock);
> > +
> >
> 
> A better option is to update mmc->actual_clock. That value is
> available (and the requested value) though the debugFS nodes.

Ok, I will change that.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170125/48834203/attachment.sig>
