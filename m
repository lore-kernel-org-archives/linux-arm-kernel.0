From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sun, 24 May 2015 11:32:53 +0800
Subject: [PATCH v9 4/4] crypto: Add Allwinner Security System crypto
 accelerator
In-Reply-To: <20150523163536.2d64ef8d@bbrezillon>
References: <1431608341-10936-1-git-send-email-clabbe.montjoie@gmail.com>
 <1431608341-10936-5-git-send-email-clabbe.montjoie@gmail.com>
 <20150517104508.468b032f@bbrezillon> <55607CB7.8020505@gmail.com>
 <20150523163536.2d64ef8d@bbrezillon>
Message-ID: <20150524033253.GB20656@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, May 23, 2015 at 04:35:36PM +0200, Boris Brezillon wrote:
>
> > Since all SG I get was always a multiple of 16 (AES BLOCK SIZE) it was a sort of confirmation.
> > 
> > Herbert ? does am I right or a chunking test is missing for cbc(aes) in testmgr.h
> 
> Okay, just sharing my vision of this thing (I'll let Herbert comment on
> this aspect): I'd say that theoretically nothing prevents one from
> splitting its sg list in chunks smaller than the block size, so I'd
> say you should use the same trick for AES. 

Indeed, you must be able to handle a block that straddles two SG
entries.  If the hardware is not capable then you have to linearise
it by copying or use a fallback.

I can't believe we don't have a generic test for this in testmgr.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
