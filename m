From: eric@anholt.net (Eric Anholt)
Date: Mon, 09 May 2016 18:05:41 -0700
Subject: [PATCH 0/5] clk: bcm2835: add flags for mash and parent clocks
In-Reply-To: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
References: <1462463608-22940-1-git-send-email-kernel@martin.sperl.org>
Message-ID: <87h9e6yb6i.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

kernel at martin.sperl.org writes:

> From: Martin Sperl <kernel@martin.sperl.org>
>
> Allow flags to be set on a per clock index basis, which control:
> * the parent clocks selected when not setting clocks explicitly

I don't think we need this other than avoiding PLLC.  What else do you
want to filter, and why?

> * the clock mode with regards to integer only or higher order mash

Please provide justification in the commit message explaining why there
is no obvious mash setting to just implement in clk-bcm2835.c, but that
that a better policy can be encoded in the DT.

Overall, I'm skeptical of this series.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160509/cfd0dcbe/attachment.sig>
