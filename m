From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 9 Nov 2015 11:58:48 +0800
Subject: [PATCH] crypto: sun4i-ss: add missing statesize
In-Reply-To: <1447006457@msgid.manchmal.in-ulm.de>
Message-ID: <20151109035848.GA2163@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de> wrote:
>
> Fixes: should rather point to the commit that caused the breakage in my
> opinion. Which did this by intention:

Absolutely not.  That patch is correct and if you revert that
you will simply end up registering a broken driver into the system
that may then lead to crashes that can be triggered from user-space.

> | commit 8996eafdcbad149ac0f772fb1649fbb75c482a6a
> | Author: Russell King <rmk+kernel@arm.linux.org.uk>
> | Date:   Fri Oct 9 20:43:33 2015 +0100
> | 
> |     crypto: ahash - ensure statesize is non-zero
> (...)
> +     This patch adds a check to prevent these drivers from registering
> +     ahash algorithms until they are fixed.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
