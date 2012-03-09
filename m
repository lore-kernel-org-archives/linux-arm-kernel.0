From: mturquette@ti.com (Turquette, Mike)
Date: Fri, 9 Mar 2012 10:35:07 -0800
Subject: [PATCH v5 0/4] common clk framework
In-Reply-To: <20120309023418.GF3261@b20223-02.ap.freescale.net>
References: <1330763341-3437-1-git-send-email-mturquette@linaro.org>
 <20120309023418.GF3261@b20223-02.ap.freescale.net>
Message-ID: <CAJOA=zOPTG-pZcQvpSPuNVduxN-3SyBGoygdALeAZFU01Bi4oQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 8, 2012 at 6:34 PM, Richard Zhao <richard.zhao@freescale.com> wrote:
> Hello Mike,
>
> The main interface for clk implementer is to register clocks dynamically.
> I think it highly depends on clk DT bindings. From the patch Grant sent
> out, it looks like he doesn't like one node per clk. So how do we
> register clocks dynamically? You have any sample code?

I can only speak for my own platform, but after talks with Paul W. and
Benoit C. I believe that OMAP will not push ALL of it's on-SoC clocks
into DT.  DT is meant to solve board-level integration problems and
the majority of OMAP clocks are SoC-level, not board level.  Some
clocks will migrate out to DT such as the primary oscillator (which
varies per board) as well as some leaf clocks and modules clocks that
depend on board-specific peripherals.

Otherwise the answer to your question is 'no'.  I don't have any
sample code for DT bindings.  It should not be hard to map some sample
clock bindings onto the existing registration functions... but it will
still be one clock per node.  I'm not really a fan of making clock
black-boxes where the details of the tree are hidden from the
framework anyways... that's something that clkdev already achieves to
some degree (by not exposing the entire tree to drivers, but only the
clocks that we want exposed).

Regards,
Mike

>
> Thanks
> Richard
>
