From: mturquette@ti.com (Turquette, Mike)
Date: Mon, 14 May 2012 22:59:41 -0700
Subject: [PATCH] clk: Constify struct clk_init_data
In-Reply-To: <4FB1E5F6.7070401@ti.com>
References: <1337004763-21250-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <20120514215304.GB3075@gmail.com> <4FB1AC79.7000901@codeaurora.org>
 <4FB1E5F6.7070401@ti.com>
Message-ID: <CAJOA=zPYY1PQsRn+TAf3QCFGd14N++8BTxnaPYc400PZgssL4A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 14, 2012 at 10:13 PM, Rajendra Nayak <rnayak@ti.com> wrote:
> Hi Saravana,
>
>
> On Tuesday 15 May 2012 06:38 AM, Saravana Kannan wrote:
>>
>> Btw, I didn't follow up on the other thread we were having, but can you
>> remind me again what was the reason that you thought that only
>> __clk_init() would work for your static init code and __clk_register()
>> won't work?
>
>
> One of the main reason has been the platform implementation we have to
> handle some complex mux/divider combo clocks in OMAP2/3 which rely on
> 'struct clk' pointers. Maybe we can do away with the existing
> implementation and redo it so we don't have any such limitation, but the
> quantum of change moving to common clk has been so much that we are
> trying to minimize on the platform code changes for now. So while
> we move to common clk it would still be useful to have __clk_init()
> around for a while till we figure out how to get rid of it for OMAP.
>

Just to add to what Rajendra has stated for OMAP: after OMAP's
conversion is finally made initcall-able then I'll get rid of lots of
the gross macros and before-the-memory-allocator-is-alive stuff.  I'll
make sure that no other platforms are using those bits of course, but
I plan on removing some of this stuff from the core once my platform
is up to speed.

Regards,
Mike

> regards,
> Rajendra
