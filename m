From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Sun, 8 Nov 2015 09:50:03 -0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <20151106045639.GA14722@gondor.apana.org.au>
References: <1446709737-11316-1-git-send-email-clabbe.montjoie@gmail.com>
 <20151105160719.GG6114@lukather>
 <20151106045639.GA14722@gondor.apana.org.au>
Message-ID: <20151108175003.GT6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 06, 2015 at 12:56:39PM +0800, Herbert Xu wrote:
> On Thu, Nov 05, 2015 at 08:07:19AM -0800, Maxime Ripard wrote:
> > 
> > On Thu, Nov 05, 2015 at 08:48:57AM +0100, LABBE Corentin wrote:
> > > sun4i-ss implementaton of md5/sha1 is via ahash algorithms.
> > > A recent change make impossible to load them without giving statesize.
> > 
> > Which one?
> 
> We recently disabled ahash drivers that do not declare statesize
> because it can lead to a crash when the driver is used through
> algif.

"Recently" is relative and really doesn't help.

Having the commit ID that made this change is an absolute reference,
and really helps to identify when that behaviour changed.

> Not declaring statesize is a bug anyway but the fact that it
> is exported through algif makes it much worse.
> 
> > > This patch specifiy statesize for sha1 and md5.
> > > 
> > > Signed-off-by: LABBE Corentin <clabbe.montjoie@gmail.com>
> > > Cc: stable at vger.kernel.org
> > 
> > Please also add a Fixes tag (and the stable version it applies to).
> 
> I don't see the point for a fixes tag as it would simply refer
> to the original patch-set that added the driver.

What's the problem with that?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151108/4a203d5f/attachment.sig>
