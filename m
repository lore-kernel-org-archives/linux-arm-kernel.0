From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Thu, 20 Aug 2015 14:44:26 +0800
Subject: un4i-ss-cipher.c warning
In-Reply-To: <20150820063900.GJ30520@lukather>
References: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
 <20150820052903.GA26031@gondor.apana.org.au>
 <20150820063900.GJ30520@lukather>
Message-ID: <20150820064426.GA26787@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 08:39:00AM +0200, Maxime Ripard wrote:
>
> Not in the dev_dbg call line 258. If ileft was negative or null, todo
> isn't assigned to anything.

If ileft starts out being <= 0, then oleft == ileft will also be
<= 0, in which case the loop never executes.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
