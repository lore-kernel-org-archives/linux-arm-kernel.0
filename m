From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Sep 2010 16:12:32 +0100
Subject: [PATCH 48/74] GIC: Added dummy handlers for Power Management
	Suspend Resume
In-Reply-To: <4C84D6B3.80104@st.com>
References: <cover.1283161023.git.viresh.kumar@st.com>
	<47425e7be671c44d949b1804436b5c301d20d793.1283161023.git.viresh.kumar@st.com>
	<20100902102323.GP26319@n2100.arm.linux.org.uk>
	<4C809486.2070308@st.com>
	<20100903073421.GF26319@n2100.arm.linux.org.uk>
	<4C84D6B3.80104@st.com>
Message-ID: <20100908151232.GD32659@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 06, 2010 at 05:25:31PM +0530, deepaksi wrote:
> On 9/3/2010 1:04 PM, Russell King - ARM Linux wrote:
> > So how are wakeup sources configured if this callback does nothing?
> > .
>
> In most of the architectures that I could refer across(including SPEAr
> family -SPEAr13xx),
> have a separate power management unit(PMU) which is required to be
> configured to define the wake
> up sources. The PMU takes care of waking up the system from sleep, as
> and when the wake up
> interrupts are triggered. This routing is independent of GIC, and hence
> the handling was not added.
> 
> Contrary to that, in some of our hardware architecture using VIC
> (including SPEAr 3xx/6xx), there
> was no explicit PMU, and the wake up trigger was exclusively done
> through VIC, and hence the VIC
> call backs had the necessary implementation.

What I read into this is that you're using enable_irq_wake() in your
drivers _and_ another mechanism to configure what wakes up the system
via the PMU - maybe with drivers explicitly calling out to the PMU
to achieve this?

This sounds a little haphazard, especially from the drivers point of
view.  Surely there's a more sensible solution to this rather than
adding do-nothing irq_wake support?
