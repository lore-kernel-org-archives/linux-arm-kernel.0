From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 16 Sep 2011 09:57:33 +0100
Subject: [RFC PATCH 01/11] OMAP: TWL: Clean up mode and ops mask passed
	from board files
In-Reply-To: <4E72F6B9.4050207@ti.com>
References: <1316085727-15023-1-git-send-email-rnayak@ti.com>
	<1316085727-15023-2-git-send-email-rnayak@ti.com>
	<20110915133236.GH7988@opensource.wolfsonmicro.com>
	<4E72F6B9.4050207@ti.com>
Message-ID: <20110916085732.GB22062@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Sep 16, 2011 at 12:41:53PM +0530, Rajendra Nayak wrote:
> On Thursday 15 September 2011 07:02 PM, Mark Brown wrote:
> >On Thu, Sep 15, 2011 at 04:51:57PM +0530, Rajendra Nayak wrote:

> >>There is no need for all the board files to pass this information
> >>additionally, when the driver already sets them by default.

> >"the driver"?  This sounds very buggy...

> Yeah, the driver currently sets some default based on what
> the chip itself supports and completely ignores the board
> inputs.
> How about the driver using the defaults and letting the boards
> override it (if it ever wants to)?
> Currently none of the boards (using any of the twl
> regulators) seem to override the defaults and that way a lot of
> this duplication in board files could be avoided.

No, this is just plain buggy.  It's fine for OMAP to have some common
stuff that the board reference but if the drivers are doing this that's
bad.  The drivers and framework shouldn't touch the hardware unless the
board says it's OK.
