From: tony@atomide.com (Tony Lindgren)
Date: Wed, 27 Mar 2013 09:50:08 -0700
Subject: [PATCH v2] ARM: OMAP: clocks: Delay clk inits atleast until
 slab is initialized
In-Reply-To: <alpine.DEB.2.00.1303270456280.8161@utopia.booyaka.com>
References: <1363863892-6810-1-git-send-email-rnayak@ti.com>
 <alpine.DEB.2.00.1303270456280.8161@utopia.booyaka.com>
Message-ID: <20130327165007.GJ25575@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Paul Walmsley <paul@pwsan.com> [130326 22:01]:
> Hi
> 
> On Thu, 21 Mar 2013, Rajendra Nayak wrote:
> 
> > clk inits on OMAP happen quite early, even before slab is available.
> > The dependency comes from the fact that the timer init code starts to
> > use clocks and hwmod and we need clocks to be initialized by then.
> > 
> > There are various problems doing clk inits this early, one is,
> > not being able to do dynamic clk registrations and hence the
> > dependency on clk-private.h. The other is, inability to debug
> > early kernel crashes without enabling DEBUG_LL and earlyprintk.
> 
> ...
> 
> > Reported-by: Piotr Haber <phaber@broadcom.com>
> > Reported-by: Tony Lindgren <tony@atomide.com>
> > Signed-off-by: Rajendra Nayak <rnayak@ti.com>
> 
> Thanks, looks good to me.  Nice patch description!
> 
> Acked-by: Paul Walmsley <paul@pwsan.com>

I applied this into omap-for-v3.9-rc3/fixes, will send a pull request
for those today.

Regards,

Tony
