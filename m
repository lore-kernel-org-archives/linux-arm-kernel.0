From: ben-linux@fluff.org (Ben Dooks)
Date: Tue, 12 Jan 2010 14:24:04 +0000
Subject: [RFC,PATCH 1/7 v2] Add a common struct clk
In-Reply-To: <20100112090149.GB26435@n2100.arm.linux.org.uk>
References: <1263279511.160551.332624337260.1.gpush@pororo>
	<4B4C376C.6080705@st.com>
	<20100112090149.GB26435@n2100.arm.linux.org.uk>
Message-ID: <20100112142404.GD18532@trinity.fluff.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2010 at 09:01:49AM +0000, Russell King - ARM Linux wrote:
> On Tue, Jan 12, 2010 at 09:48:44AM +0100, Francesco VIRLINZI wrote:
> > Hi Jeremy
> > In November I already sent a proposal on
> >  a generic linux clk framework.
> > On that I would suggest:
> >
> >>
> >> +struct clk {
> >> +	const struct clk_operations *ops;
> >>    
> >            spinlock_t lock;
> >            const char *name;
> >            int id;
> 
> Name and ID are totally pointless, unless you insist on using the clk
> API in the wrong way (like S3C does.)

I do intend to change the clock lookup on the Samsung series, but we're
currently in the process of trying to do a whole pile of work on not
only adding new SoCs but also cleaning up the existing support and making
a whole pile of code common to all the Samsung SoC family.

I never got the time to go throughly through Francesco's clock framework
but it seemed rathe rcomplicated for our current requirements and also
had a whole pile of style problems that made it really difficult to read.

-- 
Ben

Q:      What's a light-year?
A:      One-third less calories than a regular year.
