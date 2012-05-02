From: mturquette@ti.com (Mike Turquette)
Date: Wed, 2 May 2012 15:44:03 -0700
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <20120502224108.GC18402@gmail.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
 <20120502094807.GE20478@pengutronix.de> <4FA120E8.5030707@st.com>
 <20120502224108.GC18402@gmail.com>
Message-ID: <20120502224403.GD18402@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20120502-15:41, Mike Turquette wrote:
> On 20120502-17:26, Viresh Kumar wrote:
> > On 5/2/2012 3:18 PM, Sascha Hauer wrote:
> > > This needs a fixup. The clock framework used to pass in a NULL pointer
> > > as prate when a clk is not allowed to change a parents clock. This
> > > is no longer true, so we have to check for
> > > 
> > > __clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT
> > 
> > Sure. Will send fixup.
> > 
> > @Mike: When will you send your clk patches to Arnd?
> > I am asking this, because SPEAr patches are dependent on
> > them. Also, please include this patch too, in your patchset.
> > 
> > I will send a fixup.
> 
> I will take this patch in before sending my request to Arnd.  In your
> patch 0/8 you ask me to take in the series, but it looks like not all of
> the patches are going through me.  For instance patch 2/8 certainly
> looks destined for Russell.

Typo above.

s/patch 2/patch 1/

Regards,
Mike

> 
> After fixing up this patch can you resend a clean series which is only
> headed for clk-next?
> 
> Thanks,
> Mike
