From: shawnguo@kernel.org (Shawn Guo)
Date: Tue, 19 May 2015 16:08:09 +0800
Subject: [PATCH 4/9] ARM: imx: setup tctl register in device specific
 function
In-Reply-To: <3390971.xfPD4sbn1V@wuerfel>
References: <1431677507-27420-1-git-send-email-shawnguo@kernel.org>
 <1431677507-27420-5-git-send-email-shawnguo@kernel.org>
 <3390971.xfPD4sbn1V@wuerfel>
Message-ID: <20150519080809.GW1071@dragon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 15, 2015 at 10:35:51AM +0200, Arnd Bergmann wrote:
> On Friday 15 May 2015 16:11:42 shawnguo at kernel.org wrote:
> >  }
> >  
> > +static void imx1_gpt_setup_tctl(void)
> > +{
> > +       u32 tctl_val;
> > +
> > +       tctl_val = MX1_2_TCTL_FRR | MX1_2_TCTL_CLK_PCLK1 | MXC_TCTL_TEN;
> > +       __raw_writel(tctl_val, imxtm.base + MXC_TCTL);
> > +}
> > 
> 
> Could you add another upfront patch to convert all the __raw_readl/__raw_writel
> to readl_relaxed/writel_relaxed?
> 
> It would be nice if the driver was endian-safe by the time it gets moved to
> drivers/clocksource, and you don't add any unsafe accesses for the changed
> code.

Make sense.  Will do.

Shawn
