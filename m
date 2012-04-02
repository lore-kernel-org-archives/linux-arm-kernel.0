From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 2 Apr 2012 17:52:42 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <4F79D85F.4020909@codeaurora.org>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F787392.5040308@codeaurora.org>
 <20120401153450.GC8971@opensource.wolfsonmicro.com>
 <4F79D85F.4020909@codeaurora.org>
Message-ID: <20120402165242.GC24211@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 09:48:31AM -0700, Stephen Boyd wrote:
> I hope we get a better clk_get() implementation with the unified struct
> clk. Don't get me wrong, clkdev is a great improvement over open coding
> clock framework stuff in each platform. But clkdev is really just
> another platform specific implementation

Utter crap.  It is not platform specific.

> that most platforms decide to
> use. Each platform has to select the option and it breaks if two
> platforms implement __clk_get()/__clk_put() in conflicting ways.

They should go away with the common clock stuff: they are there to deal
with the implementation specific parts of struct clk, and as the common
clock stuff sorts that out, these should be provided by the common clk.

So any platform using the common clock will be compatible with any other
platform using the common clock.

If you somehow think that clkdev comes into that compatibility, you're
wrong.  It doesn't.

And if you think that a private clk implementation could have a unified
clk_get(), you're also barking mad.
