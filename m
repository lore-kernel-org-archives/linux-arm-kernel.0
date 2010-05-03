From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 3 May 2010 09:10:21 +0100
Subject: [PATCH V2] ST SPEAr: Adding support for shared irq layer
In-Reply-To: <4BDE55FA.2010207@st.com>
References: <1272369611-20988-1-git-send-email-viresh.kumar@st.com>
	<4BDA716E.6010009@st.com>
	<20100501095649.GD12172@n2100.arm.linux.org.uk>
	<4BDE55FA.2010207@st.com>
Message-ID: <20100503081021.GA19220@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 03, 2010 at 10:20:02AM +0530, Viresh KUMAR wrote:
> On 5/1/2010 3:26 PM, Russell King - ARM Linux wrote:
> > Patch looks fine - my only concern is that the IRQ subsystem isn't used
> > to decode things like serial status register interrupts.  It's supposed
> > to be used to decode the interrupt using the interrupt controllers only.
> 
> Russell,
> 
> I didn't understood your point clearly. Few weeks back i raised this query
> in LKML, and you suggested to implement this layer using irq_chained_handlers.
> And this is how it is done in multiple platforms, and GPIO everywhere.
> 
> Should i implement it some other way?

It's just a reminder that this approach shouldn't be over used.  As I said
your patch is fine.
