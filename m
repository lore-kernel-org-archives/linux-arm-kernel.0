From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 3 May 2012 00:31:02 +0100
Subject: [PATCH V3 2/8] clk: add a fixed factor clock
In-Reply-To: <20120502224403.GD18402@gmail.com>
References: <cover.1335249846.git.viresh.kumar@st.com>
 <a8f9558e0709b63673e88912d25f2173b6b410e5.1335249846.git.viresh.kumar@st.com>
 <20120502094807.GE20478@pengutronix.de> <4FA120E8.5030707@st.com>
 <20120502224108.GC18402@gmail.com> <20120502224403.GD18402@gmail.com>
Message-ID: <20120502233102.GB7066@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 02, 2012 at 03:44:03PM -0700, Mike Turquette wrote:
> On 20120502-15:41, Mike Turquette wrote:
> > On 20120502-17:26, Viresh Kumar wrote:
> > > On 5/2/2012 3:18 PM, Sascha Hauer wrote:
> > > > This needs a fixup. The clock framework used to pass in a NULL pointer
> > > > as prate when a clk is not allowed to change a parents clock. This
> > > > is no longer true, so we have to check for
> > > > 
> > > > __clk_get_flags(hw->clk) & CLK_SET_RATE_PARENT
> > > 
> > > Sure. Will send fixup.
> > > 
> > > @Mike: When will you send your clk patches to Arnd?
> > > I am asking this, because SPEAr patches are dependent on
> > > them. Also, please include this patch too, in your patchset.
> > > 
> > > I will send a fixup.
> > 
> > I will take this patch in before sending my request to Arnd.  In your
> > patch 0/8 you ask me to take in the series, but it looks like not all of
> > the patches are going through me.  For instance patch 2/8 certainly
> > looks destined for Russell.
> 
> Typo above.
> 
> s/patch 2/patch 1/

I've just pushed the latest version out for linux-next, and pulled it
across into the nightly build system.  The results should be up in a
couple of hours (and an hour more for the boot tests, not that it should
affect those.)
