From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 2 Apr 2012 18:16:42 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <4F79D85F.4020909@codeaurora.org>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F787392.5040308@codeaurora.org>
 <20120401153450.GC8971@opensource.wolfsonmicro.com>
 <4F79D85F.4020909@codeaurora.org>
Message-ID: <20120402171641.GF15197@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 02, 2012 at 09:48:31AM -0700, Stephen Boyd wrote:

> I hope we get a better clk_get() implementation with the unified struct
> clk. Don't get me wrong, clkdev is a great improvement over open coding
> clock framework stuff in each platform. But clkdev is really just
> another platform specific implementation that most platforms decide to
> use. Each platform has to select the option and it breaks if two

> Sticking devm_clk_get() into clkdev.c is simple, no new file, smaller
> diff. Great. But linking it to clkdev doesn't sound much better when
> we're trying to get rid of platform specific code and this code is
> entirely platform independent.

Why wouldn't we want to continue to use clkdev with the generic clock
framework?  There's nothing particularly wrong with clkdev and we need a
standard mechanism for doing this anyway.  Frankly I was very surprised
when I looked just now and realised that the generic framework doesn't
use it automatically, I might just send a patch for that...
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120402/4c2b6896/attachment.sig>
