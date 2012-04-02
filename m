From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 19:02:13 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <4F79E308.5090208@codeaurora.org>
References: <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F787392.5040308@codeaurora.org>
 <20120401153450.GC8971@opensource.wolfsonmicro.com>
 <4F79D85F.4020909@codeaurora.org>
 <20120402165242.GC24211@n2100.arm.linux.org.uk>
 <4F79DC03.7020503@codeaurora.org>
 <20120402170858.GG24211@n2100.arm.linux.org.uk>
 <4F79DED3.4070007@codeaurora.org>
 <20120402172133.GH24211@n2100.arm.linux.org.uk>
 <4F79E308.5090208@codeaurora.org>
Message-ID: <20120402180213.GI24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 10:34:00AM -0700, Stephen Boyd wrote:
> I do think we should improve/replace clkdev by keeping the core parts
> (device name and connection name mapping) and internalizing it in the
> common clock code. Your comment about a 1:N mapping between clocks and
> devices sounds unfortunate.

Think about it.  You have a bus with a common clock feeding all peripherals
to qualify the data on the bus.  Do you:

(a) create N individual clocks parented to a single clock for the bus
(b) return a single clock for the entire bus
