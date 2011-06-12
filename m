From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 12 Jun 2011 09:22:21 +0100
Subject: [RFC PATCH 0/2] ARM: Add a generic macro for declaring
	proc_info structs
In-Reply-To: <20110610085752.GA2129@arm.com>
References: <1307640112-5360-1-git-send-email-dave.martin@linaro.org>
	<20110609173836.GF24424@n2100.arm.linux.org.uk>
	<20110610085752.GA2129@arm.com>
Message-ID: <20110612082220.GB10283@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 10, 2011 at 09:57:52AM +0100, Dave Martin wrote:
> On Thu, Jun 09, 2011 at 06:38:36PM +0100, Russell King - ARM Linux wrote:
> > It does look very much like a sledge hammer to me.  All we're really
> > after is whether the size of the region is what we expect it to be -
> > which will tell us whether there's a T2 instruction in there.
> 
> True, although the intent was no to solve just that one problem,
> but to show how to avoid a whole variety of trivial mistakes.
> Since proc_info structs don't tend to get changed much after
> they're initially written, I guess that such mistakes don't actually
> occur very often, though.

We have several other structures encoded in assembly - and to do this
for every one would be excessive.  The amount of churn produced too
would be large.

Historically we've had little problem with these structs being wrong -
about once or twice pre-Thumb for a decade IIRC (where at least one was
down to "using an old patch but didn't update it properly for the new
proc-*.S files".)
