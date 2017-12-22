From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Fri, 22 Dec 2017 09:41:48 +0100
Subject: [PATCH RFC 1/4] crypto: engine - Permit to enqueue all async
 requests
In-Reply-To: <20171222065724.GA27149@gondor.apana.org.au>
References: <20171129084121.9385-1-clabbe.montjoie@gmail.com>
 <20171129084121.9385-2-clabbe.montjoie@gmail.com>
 <20171222065724.GA27149@gondor.apana.org.au>
Message-ID: <20171222084148.GA3024@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 22, 2017 at 05:57:24PM +1100, Herbert Xu wrote:
> On Wed, Nov 29, 2017 at 09:41:18AM +0100, Corentin Labbe wrote:
> > The crypto engine could actually only enqueue hash and ablkcipher request.
> > This patch permit it to enqueue any type of crypto_async_request.
> > 
> > Signed-off-by: Corentin Labbe <clabbe.montjoie@gmail.com>
> 
> This is going the wrong way.  We do not want to expose any of the
> base types such as crypto_alg, crypto_async_request to end-users
> and that includes drivers.  Only core API code should touch these
> base types.
> 

Hello

It's you that was suggesting using crypto_async_request:
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1474434.html
"The only wart with this scheme is that the drivers end up seeing
struct crypto_async_request and will need to convert that to the
respective request types but I couldn't really find a better way."

So I wait for any suggestion.

Regards
Corentin Labbe
