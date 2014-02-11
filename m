From: Dave.Martin@arm.com (Dave Martin)
Date: Tue, 11 Feb 2014 15:38:54 +0000
Subject: [RFC PATCH] ARM: Add imprecise abort enable/disable macro
In-Reply-To: <52F90071.4080604@codethink.co.uk>
References: <1391789955-26927-1-git-send-email-fabrice.gasnier@st.com>
 <1391789955-26927-2-git-send-email-fabrice.gasnier@st.com>
 <20140210141634.GA2794@e103592.cambridge.arm.com>
 <52F8E81E.70804@codethink.co.uk>
 <20140210152147.GE2794@e103592.cambridge.arm.com>
 <52F90071.4080604@codethink.co.uk>
Message-ID: <20140211153842.GA3035@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 10, 2014 at 04:38:09PM +0000, Ben Dooks wrote:
> On 10/02/14 15:21, Dave Martin wrote:

[...]

> >Does PCI have any way of finding out which parts of the configuration
> >space are there before you are forced to go poking around in invalid
> >address space?
> >
> >I'm guessing there may not be, otherwise this convsersation might not
> >be happening ... but I don't know too much about PCI.
> 
> IIRC for configuration accesses you have to wait for the PCIe core
> to get a response from the other end. The systems I've seen either
> poll for completion or hold the transaction until the pcie core has
> finished working.

So presumably if the other end isn't there, then it's up to the PCIe
implementation to decide how to signal that back to the CPU, or are
things more constrained than that?

I sill don't understand whether the failing probe is triggered directly
from the PCI common code in the kernel or whether it comes from the
specific bus driver.  If the latter, hacks for working round this at
least won't touch the common code, which is the preferable outcome.

Cheers
---Dave
