From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Mar 2012 00:42:58 +0000
Subject: [PATCH v7 1/3] Documentation: common clk API
In-Reply-To: <4F6A2EF5.3010008@codeaurora.org>
References: <4F6A2042.9030302@codeaurora.org>
 <20120321190741.GL3226@opensource.wolfsonmicro.com>
 <20120321193304.GO9859@atomide.com> <4F6A2EF5.3010008@codeaurora.org>
Message-ID: <20120322004258.GG16389@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 21, 2012 at 12:41:41PM -0700, Saravana Kannan wrote:
> The meaning of clk_enable/disable has been changed and they won't work  
> without calling clk_prepare/unprepare. So, these are definitely new  
> APIs. If it weren't new APIs, then none of the general drivers would  
> need to change.

Yes and no.  I disagree that the meaning of clk_enable/disable() has
changed.  It hasn't.  What has changed is the preconditions for calling
those functions, and necessarily so in the interest of being able to
unify the different implementations.
