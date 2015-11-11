From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 11 Nov 2015 14:22:10 -0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <20151109035848.GA2163@gondor.apana.org.au>
References: <1447006457@msgid.manchmal.in-ulm.de>
 <20151109035848.GA2163@gondor.apana.org.au>
Message-ID: <20151111222210.GI6114@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 09, 2015 at 11:58:48AM +0800, Herbert Xu wrote:
> Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de> wrote:
> >
> > Fixes: should rather point to the commit that caused the breakage in my
> > opinion. Which did this by intention:
> 
> Absolutely not.  That patch is correct and if you revert that
> you will simply end up registering a broken driver into the system
> that may then lead to crashes that can be triggered from user-space.

Yeah my point was that the commit log should be something like

"""
sun4i-ss implementaton of md5/sha1 is via ahash algorithms.

Commit 8996eafdcbad ('crypto: ahash - ensure statesize is non-zero')
made impossible to load them without giving statesize. This patch
specifiy statesize for sha1 and md5.

Fixes: 6298e948215f ("crypto: sunxi-ss - Add Allwinner Security System crypto accelerator")
"""

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151111/a7e0287d/attachment-0001.sig>
