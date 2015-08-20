From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 21 Aug 2015 06:08:18 +0800
Subject: un4i-ss-cipher.c warning
In-Reply-To: <55D5DC97.1040209@gmail.com>
References: <CAOMqctShdb9xEkBmuaQKfB1cwGupbfH5TS5ZB_P85Hwpn+4zAA@mail.gmail.com>
 <55D5DC97.1040209@gmail.com>
Message-ID: <20150820220818.GA2850@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 20, 2015 at 03:56:39PM +0200, Corentin LABBE wrote:
> 
> Thanks for the report, strange that I do not have that warning.
> todo is always initialized, since oleft and ileft are always > 0 at start.
> But setting todo to 0 is a simple fix.
> The following patch will suppress the warning.

Nack.  Please do not fix spurious uninitialised warnings in this
way.  Not only is this pointless but if someone introduced a real
uninitialised bug later on we'd never catch it because of this.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
