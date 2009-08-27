From: laforge@gnumonks.org (Harald Welte)
Date: Thu, 27 Aug 2009 19:32:13 +0900
Subject: 6410 issues with samsung-ap-2.6
In-Reply-To: <200908242149.n7OLnU6d017655@chronolytics.com>
References: <200908242149.n7OLnU6d017655@chronolytics.com>
Message-ID: <20090827103213.GD7524@prithivi.gnumonks.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

On Mon, Aug 24, 2009 at 05:49:30PM -0400, David F. Carlson wrote:
 
> I am (trying) to use the recently released git kki_ap/samsung-ap-2.6 which is
> supposedly a decent 6410 tree.

This tree was indeed their current development tree for a lot of code, not sure
if it was supposed to be used particularly for the 6410.

> Is there a better tree to integrate my 6410-based device with?  (I am having
> other "issues" with this git tree and the samsung folks are not helpful...)

Samsung is working right now to align their development better with mainline.

Historically, they basically did Linux ports on requests of big customers, and
every customer had a different selection of base kernel revision + specific
soc, so you end up with many different trees and parallel development.

I am right now with them in Korea, helping to define a strategy to change this,
and I'll also help [on a high level, not expecting to write much code] with the
actual implementation of it.

You will soon see a 2.6.31-rc7 based kernel in their public repo, which is
following mainline more closely.  Initially, the tree will only contain work
on the 5pc110, but the old code from the 6410, 6440 and s5pc110 will be merged
into this tree over the weeks and months to come.  After that is done, you will
see feature-by-feature patches being submitted for the official mainline kernel,
starting with 6410 and moving on to later SoC's.

Of course this is a larger project and it will not happen overnight.  But I am
confident that the goal here is to do "the right thing".  There will not be any
official announcement, as I think the facts should speak for themselves while
that change actually materializes here on this list.

Meanwhile, I think mainline is not a too bad choice for the 6410, as you can 
see Ben Dooks working regularly on it.  If you need particular drivers/features
from the samsung tree, it would obviosuly be possible to contribute to getting
that feature faster into mainline :)

Regards,
-- 
- Harald Welte <laforge@gnumonks.org>           http://laforge.gnumonks.org/
============================================================================
"Privacy in residential applications is a desirable marketing option."
                                                  (ETSI EN 300 175-7 Ch. A6)
