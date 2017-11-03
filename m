From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Fri, 3 Nov 2017 21:20:16 +0800
Subject: [PATCH] crypto: AF_ALG - remove locking in async callback
In-Reply-To: <5260911.ZuXsrgFD2R@positron.chronox.de>
References: <CAGkQfmNKbSwue13zPh2K1F_kLkpm1_AhsAHK4spRFA0xMvU5PA@mail.gmail.com>
 <5260911.ZuXsrgFD2R@positron.chronox.de>
Message-ID: <20171103132016.GB8330@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 29, 2017 at 09:39:30PM +0100, Stephan M?ller wrote:
> Am Mittwoch, 25. Oktober 2017, 17:26:31 CET schrieb Romain Izard:
> 
> Hi Romain,
> 
> the patch below should cover the issue you see. Would you mind testing it?
> 
> Thanks
> Stephan
> 
> ---8<---
> 
> The code paths protected by the socket-lock do not use or modify the
> socket in a non-atomic fashion. The actions pertaining the socket do not
> even need to be handled as an atomic operation. Thus, the socket-lock
> can be safely ignored.

Are you sure about that? In particular is the callback function still
sane without the socket lock if a concurrent recvmsg/sendmsg call is
made?

Your fixes header is wrong too as the locks weren't introduced in that
commit, they just got moved around.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
