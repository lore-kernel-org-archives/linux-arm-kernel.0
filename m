From: eric@anholt.net (Eric Anholt)
Date: Mon, 29 Feb 2016 12:43:36 -0800
Subject: [PATCH 2/2] clk: bcm2835: expose current divider,
 parent and mash via debugfs
In-Reply-To: <1456755616-2472-3-git-send-email-kernel@martin.sperl.org>
References: <1456755616-2472-1-git-send-email-kernel@martin.sperl.org>
 <1456755616-2472-3-git-send-email-kernel@martin.sperl.org>
Message-ID: <87h9gr5jt3.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> For each clock expose the following values via debugfs:
> * current_parent - the currently selected parent
> * current_divi - the integer portion of the currently set divider
> * current_divf - the fractional portion of the currently set divider
> * current_frac - the current frac/mash settings for the divider

current_parent can already be found through /debug/clk/clk_summary quite
nicely I think.  If we wanted a per-clock parent file, that seems like
something the core ought to be doing.

current_frac is looking at a bit that doesn't exist for non-MASH clocks.

divi/divf are OK, I guess, but don't seem particularly useful given the
raw register output already.  A cooked floating point point divider
debugfs entry would be nice, but I don't know if we can do that.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160229/32024f09/attachment.sig>
