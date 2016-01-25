From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 25 Jan 2016 22:48:49 +0800
Subject: [PATCH 0/5] crypto: atmel-sha: fix registration issue and other
 bugs
In-Reply-To: <cover.1452867917.git.cyrille.pitchen@atmel.com>
References: <cover.1452867917.git.cyrille.pitchen@atmel.com>
Message-ID: <20160125144849.GH8840@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 15, 2016 at 03:49:30PM +0100, Cyrille Pitchen wrote:
> Hi all,
> 
> This series of patches fixes many issues such as the algo registration failure
> or the broken support of context switches.
> 
> This series was applied to linux-next and tested on a sama5d2 xplained
> ultra board. We now pass the tcrypt tests in the following modes:
> -  2: sha1
> -  6: sha256
> - 11: sha384
> - 12: sha512
> - 33: sha224
> 
> The context switch fix was tested with a userspace program using the cryptodev
> module. This single thread program computes the SHA256 hashes of many files
> by splitting then into fixed size chunks. The chunks of each file are
> processed by calling 'update' operations using a round robin algorithm.
> 
> However, the .import() / .export() implementation was NOT tested!
> Nonetheless the last patch is needed to fix the registration issue, otherwise
> atmel_sha_probe() would still fail.

Patch 1-4 applied.  Please fix the alignment issue with patch 5.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
