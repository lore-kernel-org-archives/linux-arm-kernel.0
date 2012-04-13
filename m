From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 13 Apr 2012 12:17:16 +0800
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <4F879E9D.2090502@st.com>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411092034.GV24211@n2100.arm.linux.org.uk>
 <20120411094231.GO3852@pengutronix.de>
 <20120411094704.GY24211@n2100.arm.linux.org.uk>
 <4F879E9D.2090502@st.com>
Message-ID: <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 April 2012 11:33, Viresh Kumar <viresh.kumar@st.com> wrote:
> On 4/11/2012 3:17 PM, Russell King - ARM Linux wrote:
>>> > Indeed I have struct clk pointers, so I can instead use a to-be-written
>>> > combination of clkdev_alloc/clkdev_add. Would that be ok?
>> As we already have clkdev_alloc and clkdev_add, then I don't see that as
>> a problem - except we may have to change __clkdev_alloc() so that it can
>> be used before kmalloc() is up and running.
>
> Instead of platforms calling these routines, can we have these calls from
> clk_register_*() routines directly? So, for every clock registered with
> common clk framework this gets done automatically. We just need to pass
> dev & con id strings to these routines.
>
No.

Only small portion of the entire clock tree need to be in the lookup,
usually the leaf clocks that device drivers need to access/manage.

Regards,
Shawn
