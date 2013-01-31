From: paul@pwsan.com (Paul Walmsley)
Date: Thu, 31 Jan 2013 16:19:47 +0000 (UTC)
Subject: [PATCH] ARM: omap4: clock data: Add missing clkdm association
 for dpll_usb
In-Reply-To: <510A5908.30804@ti.com>
References: <1359095795-9538-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1301250810090.471@utopia.booyaka.com>
 <510A5908.30804@ti.com>
Message-ID: <alpine.DEB.2.00.1301311619370.32145@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 31 Jan 2013, Rajendra Nayak wrote:

> Hi Paul,
> 
> > > dpll_usb needs the clkdm association so the clkdm can be
> > > turned on before a relock. All other dplls for omap4 belong
> > > to the ALWON (always on) domain.
> > > 
> > > The association was present as part of the older data file
> > > (clock44xx_data.c) but looks like was accidently dropped with
> > > the common clk convertion.
> > 
> > Thanks, queued for v3.8-rc fixes.
> 
> I just realized that apart from adding the missing .clkdm_name, I
> also need to populate a .init as part of clk_ops for dpll_usb
> so the clockdomain lookup can then happen based on the .clkdm_name.
> 
> I have updated the $Subject patch and posted a v2 (http://marc.info
> /?l=linux-omap&m=135963212530790&w=2). Would it be possible for you to
> pick the v2 instead and drop this one from your fixes branch.

No problem.


- Paul
