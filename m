From: dave.martin@linaro.org (Dave Martin)
Date: Tue, 16 Apr 2013 15:30:18 +0100
Subject: [RFC PATCH 2/2] ARM: DT: kernel: DT cpu node bindings update
In-Reply-To: <516C544A.4090107@wwwdotorg.org>
References: <1366042402-8987-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1366042402-8987-3-git-send-email-lorenzo.pieralisi@arm.com>
 <516C544A.4090107@wwwdotorg.org>
Message-ID: <20130416143018.GB2229@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 15, 2013 at 01:26:02PM -0600, Stephen Warren wrote:
> On 04/15/2013 10:13 AM, Lorenzo Pieralisi wrote:

[...]

> > +	- enable-method
> > +		Usage: required on ARM 64-bit systems, optional on ARM 32-bit
> > +		       systems

If we define no meaningful enumerations for 32-bit systems (for example,
the spin-table boot method doesn't exist), then arguably this property
should be prohibited for 32-bit systems in this version of the binding.

The binding should be extended later when we have enable methods to add?

(enable-method = "psci" is one plausible addition)

> > +		Value type: <string>
> > +		Definition: On ARM 64-bit systems must be "spin-table" [1].
> 
> Can that be an integer instead? with dtc+cpp support, that shouldn't
> hurt the eyes too much any more.

That doesn't feel very DT-like, and it makes the standalone FDT excessively
cryptic without the headers.  Does it really matter that much?  DT parsing
should not be on any performance-critical path.

Mostly, DT convention seems to be to use legible string names for
enumerations like this.

Anything which tends to encrypt the DT content starts us on a slippery
slope IMHO.  Converting the DT back to a vaguely human-readable form
becomes impossible without the headers.

Cheers
---Dave
