From: B19295@freescale.com (Lin Tony-B19295)
Date: Fri, 2 Dec 2011 05:37:11 +0000
Subject: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting clock
 from 100ms to 1ms
In-Reply-To: <87vcq0kvs6.fsf@laptop.org>
References: <1321944150-12162-1-git-send-email-tony.lin@freescale.com>
 <87vcq0kvs6.fsf@laptop.org>
Message-ID: <97D3A72708D04647A5AC84A04996E5B526EC0F@039-SN1MPN1-001.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Okay
Thanks

> -----Original Message-----
> From: linux-mmc-owner at vger.kernel.org [mailto:linux-mmc-
> owner at vger.kernel.org] On Behalf Of Chris Ball
> Sent: Friday, December 02, 2011 2:11 AM
> To: Lin Tony-B19295
> Cc: linux-mmc at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Xie
> Xiaobo-R63061; avorontsov at ru.mvista.com
> Subject: Re: [PATCH 1/1] mmc: sdhci-esdhc: Change delay after setting
> clock from 100ms to 1ms
> 
> Hi,
> 
> On Tue, Nov 22 2011, Tony Lin wrote:
> > 1ms is enough for hardware to change the clock to stable.
> > 100ms is too long in the tasklet.
> >
> > Signed-off-by: Tony Lin <tony.lin@freescale.com>
> > CC: Xiaobo Xie <X.Xie@freescale.com>
> > CC: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> >  drivers/mmc/host/sdhci-esdhc.h |    2 +-
> >  1 files changed, 1 insertions(+), 1 deletions(-)
> >
> > diff --git a/drivers/mmc/host/sdhci-esdhc.h
> > b/drivers/mmc/host/sdhci-esdhc.h index c3b08f1..b97b2f5 100644
> > --- a/drivers/mmc/host/sdhci-esdhc.h
> > +++ b/drivers/mmc/host/sdhci-esdhc.h
> > @@ -73,7 +73,7 @@ static inline void esdhc_set_clock(struct sdhci_host
> > *host, unsigned int clock)
> >  		| (div << ESDHC_DIVIDER_SHIFT)
> >  		| (pre_div << ESDHC_PREDIV_SHIFT));
> >  	sdhci_writel(host, temp, ESDHC_SYSTEM_CONTROL);
> > -	mdelay(100);
> > +	mdelay(1);
> >  out:
> >  	host->clock = clock;
> >  }
> 
> I don't know if 1ms is actually long enough for the clock to stabilize on
> all boards, but I'll push this change to mmc-next and we can see if we
> get any regression reports.
> 
> Thanks,
> 
> - Chris.
> --
> Chris Ball   <cjb@laptop.org>   <http://printf.net/>
> One Laptop Per Child
> --
> To unsubscribe from this list: send the line "unsubscribe linux-mmc" in
> the body of a message to majordomo at vger.kernel.org More majordomo info at
> http://vger.kernel.org/majordomo-info.html
