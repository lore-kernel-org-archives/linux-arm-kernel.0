From: viresh.kumar@st.com (Viresh Kumar)
Date: Tue, 17 Apr 2012 09:04:15 +0530
Subject: [PATCH] CLKDEV: Add helper routines to allocate and add clkdevs
 for given struct clk *
In-Reply-To: <20120416204609.GA8548@glitch>
References: <cfe2a4ef4a7903696200ca3880b96b4aa98c4820.1334553491.git.viresh.kumar@st.com>
 <20120416102503.GA32687@glitch> <4F8BF4DD.2080501@st.com>
 <20120416103822.GU24211@n2100.arm.linux.org.uk>
 <CAOh2x=kXeDOeZbAACOjKiwfdEniXkvAuFbrJ+rmgw=rq_gHQAg@mail.gmail.com>
 <20120416204609.GA8548@glitch>
Message-ID: <4F8CE4B7.8090003@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/17/2012 2:16 AM, Domenico Andreoli wrote:
>> > +struct clk_lookup * __init_refok
>> > +clkdev_alloc(struct clk *clk, const char *con_id, const char *dev_fmt, ...)
>> > +{
>> > +	struct clk_lookup * cl;
>> > +	va_list ap = NULL;

> so I finally tested it with this modification:
> 
> 	if (dev_fmt) {
> 		va_start(ap, dev_fmt);
> 		cl = clkdev_alloc_valist(clk, con_id, dev_fmt, ap);
> 		va_end(ap);
> 	} else
> 		cl = clkdev_alloc(clk, con_id, NULL);

Isn't this a infinite loop now, when dev_fmt is passed as NULL?


-- 
viresh
