From: sboyd@codeaurora.org (Stephen Boyd)
Date: Tue, 11 Aug 2015 17:02:29 -0700
Subject: [PATCH 5/7] clk: atlas7: fix the clock tree for bluetooth stuff
In-Reply-To: <CAGsJ_4y=TC1LXC1CPB=c1bfY7ZR0ktMD+hVuUZWxXXpyRR9zEw@mail.gmail.com>
References: <1438064845-17894-1-git-send-email-21cnbao@gmail.com>
 <1438064845-17894-6-git-send-email-21cnbao@gmail.com>
 <55B7FD22.10609@codeaurora.org>
 <CAGsJ_4wg1+5KrwTJRzE-iaSTvgvgFrM6cDyUTL16gx6Hk+tdPw@mail.gmail.com>
 <55C2BBED.4050608@codeaurora.org>
 <CAGsJ_4y=TC1LXC1CPB=c1bfY7ZR0ktMD+hVuUZWxXXpyRR9zEw@mail.gmail.com>
Message-ID: <20150812000229.GB26614@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10, Barry Song wrote:
> 2015-08-06 9:44 GMT+08:00 Stephen Boyd <sboyd@codeaurora.org>:
> >
> > This actually points out a big problem we have right now in Linux, which is
> > the lack of proper power management for the type of bus topology you see in
> > embedded systems. Some of the genpd work going on may also be another
> > solution to this problem, where we could group multiple devices into generic
> > power domains that know to turn on 2 or 3 of the clocks. For example, the
> > DMAC, USP, and UART device could all be in the APB power domain so that the
> > a7ca_io_clk is enabled whenever one of those devices is active. And there
> > could be another power domain for the NOC that encompasses all devices that
> > are sitting on that NOC.
> >
> 
> Stephen, this should be a possible option, i will talk with HW guys to
> figure out the relationship of power domain, and check whether we
> handle this issue by the power domain solution.
> 
> btw, would you apply other patches in this series at first? we can
> hold on this one to find a final solution.
> 

Yes. I'll apply the rest to clk-next.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
