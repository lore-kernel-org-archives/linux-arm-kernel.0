From: viresh.kumar@st.com (Viresh Kumar)
Date: Thu, 1 Mar 2012 09:21:15 +0530
Subject: [PATCH] ARM/sp810: introduce API to change system mode
In-Reply-To: <20120229201413.GA16999@n2100.arm.linux.org.uk>
References: <bd90082f199c9bd0e48e0177ced627a50d5f850e.1329988357.git.viresh.kumar@st.com>
 <20120229201413.GA16999@n2100.arm.linux.org.uk>
Message-ID: <4F4EF233.70405@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/1/2012 1:44 AM, Russell King - ARM Linux wrote:
>> >  #define SCCTRL			0x000
>> > +	#define SYS_MODE_STS_MASK		(0xF << 3)
>> > +	#define SYS_MODE_STS_SLEEP		(0x0 << 3)
>> > +	#define SYS_MODE_STS_DOZE		(0x1 << 3)
>> > +	#define SYS_MODE_STS_SLOW		(0x2 << 3)
>> > +	#define SYS_MODE_STS_NORMAL		(0x4 << 3)
>> > +
>> > +	#define SYS_MODE_MASK			(0x7 << 0)
>> > +	#define SYS_MODE_SLEEP			(0x0 << 0)
>> > +	#define SYS_MODE_DOZE			(0x1 << 0)
>> > +	#define SYS_MODE_SLOW			(0x2 << 0)
>> > +	#define SYS_MODE_NORMAL			(0x4 << 0)
> Please don't indent #defines like this, I find it abhorrent that, at least,
> the '#' is not in column 1.
> 

I will change it if you want, but this one looked more readable to me.

> Also, please name these constants SCCTRL_xxx so that the prefix matches
> the register which they're related to.
> 
> So, I'd much prefer these to be:
> 
> #define SCCTRL_MODE_STS_MASK			(0xf << 3)

Sure.

-- 
viresh
