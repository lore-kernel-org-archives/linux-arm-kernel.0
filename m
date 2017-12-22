From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 22 Dec 2017 10:34:18 +0100
Subject: [PATCH RFC 1/4] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <20171222090603.GB32542@gondor.apana.org.au>
References: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
 <20171129084121.9385-2-clabbe.montjoie@gmail.com>
 <20171222065724.GA27149@gondor.apana.org.au>
 <20171222084148.GA3024@Red>
 <20171222090603.GB32542@gondor.apana.org.au>
Message-ID: <20171222093418.GB3024@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 08:06:03PM +1100, Herbert Xu wrote:
> On Fri, Dec 22, 2017 at 09:41:48AM +0100, Corentin Labbe wrote:
> >
> > It's you that was suggesting using crypto_async_request:
> > https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html
> > "The only wart with this scheme is that the drivers end up seeing
> > struct crypto_async_request and will need to convert that to the
> > respective request types but I couldn't really find a better way."
> > 
> > So I wait for any suggestion.
> 
> The core engine code obviously will use the base type but it should
> not be exposed to the driver authors.  IOW all exposed API should
> take the final types such as aead_request before casting it.
> 

For driver->engine calls(crypto_finalize_request/crypto_transfer_request_to_engine) it's easy.

But I do not see how to do it for crypto_engine_op appart re-introducing the big if/then/else that
you didnt want.
Or do you agree to set the request parameter for crypto_engine_op(prepare_request/unprepare_request/do_one_request) to void * ?

Regards
