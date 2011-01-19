From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 19 Jan 2011 08:52:46 +0000
Subject: [PATCH V4 07/62] ST SPEAr13XX: Adding machine specific src files
In-Reply-To: <20110119060308.GA24820@DLHLAP0379>
References: <cover.1295333957.git.viresh.kumar@st.com>
	<86b571fe06bdc264254a4125ec32195fdff46457.1295333958.git.viresh.kumar@st.com>
	<20110118160655.GD16980@n2100.arm.linux.org.uk>
	<20110119060308.GA24820@DLHLAP0379>
Message-ID: <20110119085246.GA30307@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 19, 2011 at 11:33:09AM +0530, Shiraz Hashim wrote:
> Hello Russell,
> 
> On Wed, Jan 19, 2011 at 12:06:55AM +0800, Russell King - ARM Linux wrote:
> > Do you really need to sync back to L2, or will a dsb() do here - and
> > as the spinlock code uses dsb() + sev() together, would it make sense
> > to combine the two?  (dsb() is required to ensure all previous writes
> > are visible prior to the sev() executing.)
> 
> Presently L2 cache is initialized after we bootup secondary CPU but
> one can have the possibility of initializing L2 earlier also.
> So this would be safer.

It shouldn't make any difference as we explicitly flush the required
data for the secondary while it is incoherent out of L2 into RAM -
that being secondary_data and pen_release.
