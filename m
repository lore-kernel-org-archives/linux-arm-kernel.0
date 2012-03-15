From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 15 Mar 2012 14:30:27 +0530
Subject: [PATCH] ARM: SPEAr600: Add device-tree support to SPEAr600 boards
In-Reply-To: <201203150948.27918.sr@denx.de>
References: <1331650032-15274-1-git-send-email-sr@denx.de>
 <4F604321.9000204@st.com> <201203150948.27918.sr@denx.de>
Message-ID: <4F61AFAB.6080301@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/15/2012 2:18 PM, Stefan Roese wrote:
>>> > > +static const struct of_device_id vic_of_match[] __initconst = {
>>> > > +	{ .compatible = "arm,pl190-vic", .data = vic_of_init, },
>>> > > +	{ /* Sentinel */ }
>>> > > +};
>>> > > +
>>> > > +static void __init spear6xx_dt_init_irq(void)
>>> > > +{
>>> > > +	of_irq_init(vic_of_match);
>>> > > +}
>>> > > +
>> > 
>> > What about adding this routine in vic.c file, which can then be used
>> > by all platforms, instead of replicating this code.
> We can't move vic_of_match to the vic.c, since there are differences between 
> the boards using it. And only moving spear6xx_dt_init_irq() (renamed of 
> course) doesn't seem worth it.

I knew this. Actually my thought was, we have two compatible strings for vic:
pl190 and pl192.

So, create two vic_of_match* arrays and two vic*_dt_init_irq() routines.
That will solve the issue i believe.

-- 
viresh
