From: rnayak@ti.com (Rajendra Nayak)
Date: Tue, 15 May 2012 10:43:26 +0530
Subject: [PATCH] clk: Constify struct clk_init_data
In-Reply-To: <4FB1AC79.7000901@codeaurora.org>
References: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120514215304.GB3075@gmail.com> <4FB1AC79.7000901@codeaurora.org>
Message-ID: <4FB1E5F6.7070401@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Saravana,

On Tuesday 15 May 2012 06:38 AM, Saravana Kannan wrote:
> Btw, I didn't follow up on the other thread we were having, but can you
> remind me again what was the reason that you thought that only
> __clk_init() would work for your static init code and __clk_register()
> won't work?

One of the main reason has been the platform implementation we have to
handle some complex mux/divider combo clocks in OMAP2/3 which rely on
'struct clk' pointers. Maybe we can do away with the existing
implementation and redo it so we don't have any such limitation, but the
quantum of change moving to common clk has been so much that we are
trying to minimize on the platform code changes for now. So while
we move to common clk it would still be useful to have __clk_init()
around for a while till we figure out how to get rid of it for OMAP.

regards,
Rajendra
