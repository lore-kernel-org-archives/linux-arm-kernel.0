From: sboyd@codeaurora.org (Stephen Boyd)
Date: Wed, 28 Jun 2017 15:29:29 -0700
Subject: [PATCH 1/5] clk: mb86s7x: Suppress build
In-Reply-To: <CAJe_ZhdkfK1wB88hrMP=kmMNBfqxGtHDxseuyUXHToq77bzQ+g@mail.gmail.com>
References: <20170625170020.11791-1-afaerber@suse.de>
 <20170625170020.11791-2-afaerber@suse.de>
 <20170628161354.GB5316@codeaurora.org>
 <CAJe_ZhdkfK1wB88hrMP=kmMNBfqxGtHDxseuyUXHToq77bzQ+g@mail.gmail.com>
Message-ID: <20170628222929.GC5316@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/28, Jassi Brar wrote:
> On 28 June 2017 at 21:43, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > On 06/25, Andreas F?rber wrote:
> >> It fails to build once we introduce the ARCH_MB86S7X Kconfig symbol:
> >>
> >>   drivers/clk/clk-mb86s7x.c:27:10: fatal error: soc/mb86s7x/scb_mhu.h: No such file or directory
> >>    #include <soc/mb86s7x/scb_mhu.h>
> >>             ^~~~~~~~~~~~~~~~~~~~~~~
> >>   compilation terminated.
> >>
> >> And when commenting out that line, we get:
> >>
> >>   drivers/clk/clk-mb86s7x.c: In function 'crg_gate_control':
> >>   drivers/clk/clk-mb86s7x.c:72:8: error: implicit declaration of function 'mb86s7x_send_packet' [-Werror=implicit-function-declaration]
> >>     ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
> >>           ^~~~~~~~~~~~~~~~~~~
> >>   drivers/clk/clk-mb86s7x.c:72:28: error: 'CMD_PERI_CLOCK_GATE_SET_REQ' undeclared (first use in this function)
> >>     ret = mb86s7x_send_packet(CMD_PERI_CLOCK_GATE_SET_REQ,
> >>                               ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>   drivers/clk/clk-mb86s7x.c:72:28: note: each undeclared identifier is reported only once for each function it appears in
> >>   drivers/clk/clk-mb86s7x.c: In function 'crg_rate_control':
> >>   drivers/clk/clk-mb86s7x.c:116:10: error: 'CMD_PERI_CLOCK_RATE_SET_REQ' undeclared (first use in this function)
> >>      code = CMD_PERI_CLOCK_RATE_SET_REQ;
> >>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>   drivers/clk/clk-mb86s7x.c:121:10: error: 'CMD_PERI_CLOCK_RATE_GET_REQ' undeclared (first use in this function); did you mean 'CMD_PERI_CLOCK_RATE_SET_REQ'?
> >>      code = CMD_PERI_CLOCK_RATE_GET_REQ;
> >>             ^~~~~~~~~~~~~~~~~~~~~~~~~~~
> >>             CMD_PERI_CLOCK_RATE_SET_REQ
> >>   drivers/clk/clk-mb86s7x.c: In function 'mhu_cluster_rate':
> >>   drivers/clk/clk-mb86s7x.c:276:10: error: 'CMD_CPU_CLOCK_RATE_GET_REQ' undeclared (first use in this function)
> >>      code = CMD_CPU_CLOCK_RATE_GET_REQ;
> >>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>   drivers/clk/clk-mb86s7x.c:278:10: error: 'CMD_CPU_CLOCK_RATE_SET_REQ' undeclared (first use in this function); did you mean 'CMD_CPU_CLOCK_RATE_GET_REQ'?
> >>      code = CMD_CPU_CLOCK_RATE_SET_REQ;
> >>             ^~~~~~~~~~~~~~~~~~~~~~~~~~
> >>             CMD_CPU_CLOCK_RATE_GET_REQ
> >>   cc1: some warnings being treated as errors
> >>   scripts/Makefile.build:302: recipe for target
> >>   'drivers/clk/clk-mb86s7x.o' failed
> >>   make[2]: *** [drivers/clk/clk-mb86s7x.o] Error 1
> >>
> >> Comment it out in the Makefile for now.
> >>
> >
> > Why not delete the whole driver instead? It's been two years and
> > the driver has never compiled.
> >
> I won't complain. The interest of moving powers evaporated in the
> midst of upstreaming. Though some next platform is supposed to reuse
> the IPs, but I can't say when will that be upstreamed and by whom.
> 

Thanks for the info.

Andreas, can you send a deletion patch instead?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
