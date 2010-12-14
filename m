From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 14 Dec 2010 09:34:50 +0000
Subject: [PATCH 3/4] process: Add display of memory around registers
	when displaying regs.
In-Reply-To: <1292302659-1863-4-git-send-email-john.stultz@linaro.org>
References: <1292302659-1863-1-git-send-email-john.stultz@linaro.org>
	<1292302659-1863-4-git-send-email-john.stultz@linaro.org>
Message-ID: <20101214093450.GC18425@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 13, 2010 at 08:57:38PM -0800, John Stultz wrote:
> From: San Mehat <san@google.com>
> 
> This is extremely useful in diagnosing remote crashes, and is based heavily
> on original work by <md@google.com>.

Why reinvent dump_mem() ?

If we dump out two lines of data per register, that's 32 additional
lines in the oops dump.  That might make it difficult to get the
register information which may have been lost off the scrollback.

Or worse still, it might wrap the kernel buffers before syslog gets
it.
