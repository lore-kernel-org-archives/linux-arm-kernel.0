From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 29 Jan 2010 14:21:05 +0000
Subject: [RFC PATCH 11/12] arm: vfp: Add additional vfp interfaces
In-Reply-To: <1264719577-5436-12-git-send-email-dwalker@codeaurora.org>
References: <1264719577-5436-12-git-send-email-dwalker@codeaurora.org>
Message-ID: <20100129142105.GC16712@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 28, 2010 at 02:59:36PM -0800, Daniel Walker wrote:
> From: Dave Estes <cestes@quicinc.com>
> 
> Refactor common code to vfp_flush_context() and vfp_reinit().  Allow
> use by other client beside suspend/resume.  Currently intended for
> idle power collapse.

I'm sure the OMAP people would be interested in this kind of thing as
well - maybe rather than creating a raft of global functions where the
callers have to be #ifdef'd, we could use the technology which we have
in the kernel such as a notifier list?

That'd mean that VFP and L2 cache could hook themselves onto that list
and get notified about these power down/up events.
