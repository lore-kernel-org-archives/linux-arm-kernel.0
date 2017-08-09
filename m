From: tony@atomide.com (Tony Lindgren)
Date: Wed, 9 Aug 2017 15:02:30 -0700
Subject: [PATCH v2 2/2] ARM: OMAP4+: PRM: fix of_irq_get() result checks
In-Reply-To: <80dd8051-456b-2331-b847-0631d94f85b1@cogentembedded.com>
References: <20170806151714.108596802@cogentembedded.com>
 <80dd8051-456b-2331-b847-0631d94f85b1@cogentembedded.com>
Message-ID: <20170809220229.GI3934@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [170806 08:20]:
> On 08/06/2017 06:14 PM, Sergei Shtylyov wrote:
> 
> > of_irq_get() may return 0 as well as a nagative error number on failure,
> 
>    Oops, forgot to kill comma...

I can fix that while applying.

> > (and never on success), however omap44xx_prm_late_init() regards 0 as a
> > valid IRQ -- fix this.
> > 
> > Fixes: a8f83aefcd5a ("ARM: OMAP4+: PRM: register interrupt information from DT")
> > Fixes: c5b3955828ba ("ARM: OMAP4: Fix legacy code clean-up regression")
> > Signed-off-by: Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
> [...]

Seems these both should be safe to apply into fixes-not-urgent for
v4.14 merge window as we have not seen any issues with this? Or
are there some known bugs related to this?

Regards,

Tony
