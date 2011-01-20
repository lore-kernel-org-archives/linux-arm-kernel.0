From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 20 Jan 2011 18:56:17 +0000
Subject: Locking in the clk API
In-Reply-To: <4D3862DB.5000708@fluff.org>
References: <201101111016.42819.jeremy.kerr@canonical.com>
	<20110111031552.GJ3760@linux-sh.org> <4D3862DB.5000708@fluff.org>
Message-ID: <20110120185617.GI6335@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 20, 2011 at 04:29:15PM +0000, Ben Dooks wrote:
> I really don't like the fact that people are doing these things in
> atomic contexts, and I think we should apply some pressure to move
> the atomic caller cases to use systems where they can sleep such as
> using threaded-irq handlers (they work very nicely)

How do you ensure that printk is always called from a non-atomic
context?
