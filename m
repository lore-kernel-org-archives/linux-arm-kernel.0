From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 1 Apr 2012 16:34:50 +0100
Subject: [PATCH 2/2] clkdev: Implement managed clk_get()
In-Reply-To: <4F787392.5040308@codeaurora.org>
References: <1333279960-8497-1-git-send-email-broonie@opensource.wolfsonmicro.com>
 <1333279960-8497-2-git-send-email-broonie@opensource.wolfsonmicro.com>
 <4F787392.5040308@codeaurora.org>
Message-ID: <20120401153450.GC8971@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 01, 2012 at 08:26:10AM -0700, Stephen Boyd wrote:
> On 4/1/2012 4:32 AM, Mark Brown wrote:

> >  Documentation/driver-model/devres.txt |    3 +++
> >  drivers/clk/clkdev.c                  |   25 +++++++++++++++++++++++++
> >  include/linux/clk.h                   |   20 ++++++++++++++++++++
> >  3 files changed, 48 insertions(+), 0 deletions(-)

> But why is this part of clkdev.c? devm_clk_get() should work regardless
> of the implementation of clk_get() so can we put it into some other file
> that is compiled if HAVE_CLK=y so everyone benefits from this and not
> just users who select CLKDEV_LOOKUP?

Mostly just because clk_get() is part of clkdev.c and I didn't feel like
creating a new file, though also because I really hope that we're going
to be moving away from open coding clock framework things so that we can
start to push clock API usage into non-SoC code.  Things like adding new
clocks are going to be a part of that.

To put it another way, why would a platform want to avoid clkdev?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120401/9bba3e11/attachment-0001.sig>
