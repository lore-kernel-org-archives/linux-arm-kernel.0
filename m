From: mturquette@ti.com (Mike Turquette)
Date: Wed, 10 Oct 2012 18:36:31 -0700
Subject: [PATCH] clk: fix return value check in bcm2835_init_clocks()
In-Reply-To: <CAPgLHd-msJkHz5KxsxVhr0u8ainXU0t53XHeiwSeW2ShJkRbwg@mail.gmail.com>
References: <CAPgLHd95ofKiKWC9B67q9mgkjsc6_YJ5x92aY0xKPiohuUMk4Q@mail.gmail.com>
 <50738C7A.9060905@wwwdotorg.org>
 <CAPgLHd-msJkHz5KxsxVhr0u8ainXU0t53XHeiwSeW2ShJkRbwg@mail.gmail.com>
Message-ID: <20121011013631.11595.26416@nucleus>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Wei Yongjun (2012-10-08 19:44:47)
> On 10/09/2012 10:31 AM, Stephen Warren wrote:
> > On 10/07/2012 08:02 AM, Wei Yongjun wrote:
> >> From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >>
> >> In case of error, the function clk_register_fixed_rate() returns
> >> ERR_PTR() and never returns NULL. The NULL test in the return value
> >> check should be replaced with IS_ERR().
> >>
> >> dpatch engine is used to auto generate this patch.
> >> (https://github.com/weiyj/dpatch)
> > Acked-by: Stephen Warren <swarren@wwwdotorg.org>
> >
> > Mike, this driver was added through arm-soc; I assume it's simplest to
> > take this fixup through there too for 3.7-rc*? If so, Wei, could you
> > resend this patch with my ack to arm at kernel.org? Thanks.
> 
> Will do, thanks.

Works for me.

Mike
