From: linux-kernel.bfrz@manchmal.in-ulm.de (Christoph Biedl)
Date: Sun, 8 Nov 2015 19:22:38 +0100
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <20151108175003.GT6114@lukather>
References: <1446709737-11316-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151105160719.GG6114@lukather>
 <20151106045639.GA14722@gondor.apana.org.au>
 <20151108175003.GT6114@lukather>
Message-ID: <1447006457@msgid.manchmal.in-ulm.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Maxime Ripard wrote...

> > > > This patch specifiy statesize for sha1 and md5.
> > > > 
> > > > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > > Cc: stable at vger.kernel.org
> > > 
> > > Please also add a Fixes tag (and the stable version it applies to).
> > 
> > I don't see the point for a fixes tag as it would simply refer
> > to the original patch-set that added the driver.
> 
> What's the problem with that?

Fixes: should rather point to the commit that caused the breakage in my
opinion. Which did this by intention:

| commit 8996eafdcbad149ac0f772fb1649fbb75c482a6a
| Author: Russell King <rmk+kernel@arm.linux.org.uk>
| Date:   Fri Oct 9 20:43:33 2015 +0100
| 
|     crypto: ahash - ensure statesize is non-zero
(...)
+     This patch adds a check to prevent these drivers from registering
+     ahash algorithms until they are fixed.

Another crypto subsystem (mv_cesa) suffers from the same problem. I
have a patch ready but would prefer a consensus on these formalities
before submitting.

Aside from this, if you really need another Tested-by:, add me. And
also Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=107281

    Christoph
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/2e54c0cc/attachment.sig>
