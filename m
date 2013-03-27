From: paul@pwsan.com (Paul Walmsley)
Date: Wed, 27 Mar 2013 04:57:33 +0000 (UTC)
Subject: [PATCH v2] ARM: OMAP: clocks: Delay clk inits atleast until slab
 is initialized
In-Reply-To: <1363863892-6810-1-git-send-email-rnayak@ti.com>
References: <1363863892-6810-1-git-send-email-rnayak@ti.com>
Message-ID: <alpine.DEB.2.00.1303270456280.8161@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi

On Thu, 21 Mar 2013, Rajendra Nayak wrote:

> clk inits on OMAP happen quite early, even before slab is available.
> The dependency comes from the fact that the timer init code starts to
> use clocks and hwmod and we need clocks to be initialized by then.
> 
> There are various problems doing clk inits this early, one is,
> not being able to do dynamic clk registrations and hence the
> dependency on clk-private.h. The other is, inability to debug
> early kernel crashes without enabling DEBUG_LL and earlyprintk.

...

> Reported-by: Piotr Haber <phaber@broadcom.com>
> Reported-by: Tony Lindgren <tony@atomide.com>
> Signed-off-by: Rajendra Nayak <rnayak@ti.com>

Thanks, looks good to me.  Nice patch description!

Acked-by: Paul Walmsley <paul@pwsan.com>


- Paul
