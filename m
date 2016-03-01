From: bjorn.andersson@linaro.org (Bjorn Andersson)
Date: Tue, 1 Mar 2016 09:27:20 -0800
Subject: [PATCH] soc: qcom: smp2p: Use memset_io to zero out new entries
In-Reply-To: <alpine.DEB.2.02.1603011706210.14948@utopia.booyaka.com>
References: <1456417057-17591-1-git-send-email-bjorn.andersson@linaro.org>
 <20160225220224.GA9986@hector.attlocal.net>
 <alpine.DEB.2.02.1603011706210.14948@utopia.booyaka.com>
Message-ID: <20160301172720.GS21240@tuxbot>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 01 Mar 09:10 PST 2016, Paul Walmsley wrote:

> On Thu, 25 Feb 2016, Andy Gross wrote:
> 
> > On Thu, Feb 25, 2016 at 08:17:37AM -0800, Bjorn Andersson wrote:
> > > Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> > > ---
> > >  drivers/soc/qcom/smp2p.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/soc/qcom/smp2p.c b/drivers/soc/qcom/smp2p.c
> > > index f1eed7f9dd67..61df598444e6 100644
> > > --- a/drivers/soc/qcom/smp2p.c
> > > +++ b/drivers/soc/qcom/smp2p.c
> > > @@ -379,7 +379,7 @@ static int qcom_smp2p_alloc_outbound_item(struct qcom_smp2p *smp2p)
> > >  		return PTR_ERR(out);
> > >  	}
> > >  
> > > -	memset(out, 0, sizeof(*out));
> > > +	memset_io(out, 0, sizeof(*out));
> > >  	out->magic = SMP2P_MAGIC;
> > >  	out->local_pid = smp2p->local_pid;
> > >  	out->remote_pid = smp2p->remote_pid;
> > 
> > Good catch.  I'll add this fix for the pull.
> 
> Folks, is qmem_smem_get() intended to return pointers to device-mapped 
> memory, as implied by this change?
> 
> If so, shouldn't the return type of qmem_smem_get() et al. be void 
> __iomem * rather than void *?
> 

The shared memory is remapped system ram, so it should not be device
mapped. I've discussed this with Andy in the past and we'll try to get
the discussions settled during next week's Linaro Connect.

Regards,
Bjorn
