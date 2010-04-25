From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 25 Apr 2010 09:18:21 +0800
Subject: [PATCH] net/ipsec: don't treat EINPROGRESS as a regular error
In-Reply-To: <20100424144215.GA9057@Chamillionaire.breakpoint.cc>
References: <4B12F9E7.1020207@gmail.com>
	<20091130211531.GK18101@deprecation.cyrius.com>
	<4B144627.7060901@gmail.com>
	<20091204212847.GC28480@deprecation.cyrius.com>
	<4BCB4009.70707@gmail.com>
	<20100418191719.GA2508@Chamillionaire.breakpoint.cc>
	<4BCE125F.30200@gmail.com>
	<20100424144215.GA9057@Chamillionaire.breakpoint.cc>
Message-ID: <20100425011821.GA5284@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 24, 2010 at 04:42:15PM +0200, Sebastian Andrzej Siewior wrote:
> a driver might drop EINPROGRESS because its internal queue is full and
> not because something went wrong. In that case there will be another
> call back invocation and the stack should not free the skb.
> 
> Signed-off-by: Sebastian Andrzej Siewior <sebastian@breakpoint.cc>

This should only be possible when we use the MAY_BACKLOG flag,
as otherwise EINPROGRESS should never be used on the completion
function unless it's a real error.

Which algorithm is generating EINPROGRESS in this case?

Thanks,
-- 
Visit Openswan at http://www.openswan.org/
Email: Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
