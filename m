From: viresh.kumar@st.com (Viresh Kumar)
Date: Fri, 13 Apr 2012 10:36:11 +0530
Subject: [PATCH 01/40] clkdev: add clkname to struct clk_lookup
In-Reply-To: <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
References: <1334065553-7565-1-git-send-email-s.hauer@pengutronix.de>
 <1334065553-7565-2-git-send-email-s.hauer@pengutronix.de>
 <20120410143055.GT24211@n2100.arm.linux.org.uk>
 <20120410161142.GG3852@pengutronix.de>
 <20120411011149.GA20818@b20223-02.ap.freescale.net>
 <20120411082401.GA32187@sirena.org.uk>
 <20120411084528.GB20818@b20223-02.ap.freescale.net>
 <20120411092034.GV24211@n2100.arm.linux.org.uk>
 <20120411094231.GO3852@pengutronix.de>
 <20120411094704.GY24211@n2100.arm.linux.org.uk>	<4F879E9D.2090502@st.com>
 <CAAQ0ZWQ-ERDtCgEL9hJysX+-pW-K1O315t9PWoc1RMidLPpppg@mail.gmail.com>
Message-ID: <4F87B443.6090405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/13/2012 9:47 AM, Shawn Guo wrote:
>> >
>> > Instead of platforms calling these routines, can we have these calls from
>> > clk_register_*() routines directly? So, for every clock registered with
>> > common clk framework this gets done automatically. We just need to pass
>> > dev & con id strings to these routines.
>> >
> No.
> 
> Only small portion of the entire clock tree need to be in the lookup,
> usually the leaf clocks that device drivers need to access/manage.

I am not asking to enforce this for all clocks and create too many clk lookups.
But do it for all clk_register() calls, that have valid dev_id or con_id.

Apart from device clocks, there are other clocks, parent selection, etc
that need it, so that we can do clk_get_sys().

-- 
viresh
