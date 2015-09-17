From: davem@davemloft.net (David Miller)
Date: Thu, 17 Sep 2015 15:12:47 -0700 (PDT)
Subject: mvneta: SGMII fixed-link not so fixed
In-Reply-To: <20150914114209.GL21084@n2100.arm.linux.org.uk>
References: <20150914103207.GH21084@n2100.arm.linux.org.uk>
 <55F6AA25.2070603@list.ru>
 <20150914114209.GL21084@n2100.arm.linux.org.uk>
Message-ID: <20150917.151247.2129216999071943354.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Russell King - ARM Linux <linux@arm.linux.org.uk>
Date: Mon, 14 Sep 2015 12:42:09 +0100

> Thanks, I think that will solve it.  I have to wonder why that patch
> (f8af8e6eb9509 in mainline) didn't made it into v4.2 though, as it's
> billed as a regression that occurred in the previous merge window, and
> given that it was sent in July, and we're now in September.  As it
> wasn't in v4.2, it looks like it should be a stable candidate.

The series had a whole bunch of non bug fixes in it and we were in
the final phases of 4.2, in which case I defer to applying patches
to net-next only unless I'm told otherwise.

It's up the the patch/series author to let me know that an important
regression fix is hidden in there, but they should have submitted
it seperately from the rest in that kind of situation anyways.

> David, any objections to having the stable guys pick this regression
> fix up, if not already done so?

More than this patch is needed, the one before it (3/4) instantiates
the necessary property in the DT, for example.

I can queue up the whole series for -stable if you want.
