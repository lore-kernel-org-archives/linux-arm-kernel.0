From: olof@lixom.net (Olof Johansson)
Date: Thu, 31 Jul 2014 20:47:43 -0700
Subject: [PATCH] bus: arm-ccn: Fix error handling at event allocation
In-Reply-To: <1406819797-8372-1-git-send-email-pawel.moll@arm.com>
References: <1406819797-8372-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20140801034743.GA18052@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 31, 2014 at 04:16:37PM +0100, Pawel Moll wrote:
> The bitfield allocation function returns error condition
> as a negative value, but in two cases its result
> was assigned to an unsigned member of the hw_perf_event
> structure, thus the error would not be ever detected.
> 
> Fixed by using an intermediate, signed variable.
> 
> Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> ---
> 
> Dan discovered the problem using his static checker. Thanks, Dan!
> 
> Arnd, would you pick up the patch as it is or do you want me
> to send a pull request for a "ccn/fixes" branch?

I've started to prefer applying patches for cases like these, single-patch
pull requests are actually more work than doing that.

So: applied on top of next/drivers, where the CCN driver was merged
as well.


Thanks!


-Olof
