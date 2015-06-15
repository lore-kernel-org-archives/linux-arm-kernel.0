From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 15 Jun 2015 20:38:39 +0800
Subject: [RESEND PATCH v4 04/14] crypto: add a new driver for Marvell's
 CESA
In-Reply-To: <20150615133135.47ffd3e3@bbrezillon>
References: <1434093366-14681-1-git-send-email-boris.brezillon@free-electrons.com>
 <1434093366-14681-5-git-send-email-boris.brezillon@free-electrons.com>
 <20150615095421.GA32158@gondor.apana.org.au>
 <20150615133135.47ffd3e3@bbrezillon>
Message-ID: <20150615123839.GA1646@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 15, 2015 at 01:31:35PM +0200, Boris Brezillon wrote:
>
> I haven't found any driver updating the req->info field with the new
> IV. Could you point me to one of them.

This is an integral part of the API so if any driver isn't doing
this then they should be fixed.

Ironically the original mv_cesa driver gets this right :)
 
> Yes, that makes sense, but since a lot a drivers (if not all of them)
> are not updating this field we'll break them when adding this test
> unless we make it optional (with a new flag ?).

No this has been part of the API since day one so it's definitely
not optional.

> Do you have any suggestion to address this problem ?

Adding a self-test would be a good start.  That should automatically
disable any broken drivers and then we can fix them one by one.  Many
drivers implement an AEAD interface and that can still be used even
if we add the self-test.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
