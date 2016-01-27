From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 27 Jan 2016 22:17:26 +0800
Subject: [PATCH v2 1/2] crypto: sunxi - don't print confusing data
In-Reply-To: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
References: <1453815902-3070323-1-git-send-email-arnd@arndb.de>
Message-ID: <20160127141726.GB1601@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 26, 2016 at 02:44:50PM +0100, Arnd Bergmann wrote:
> gcc correctly warns that the printk output contains a variable that
> it thinks is not initialized in some cases:
> 
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c: In function 'sun4i_ss_cipher_poll':
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:254:76: warning: 'todo' may be used uninitialized in this function [-Wmaybe-uninitialized]
> drivers/crypto/sunxi-ss/sun4i-ss-cipher.c:144:15: note: 'todo' was declared here
> 
> A closer look at the function reveals that the variable is always
> initialized at this point (ileft is guaranteed to be positive at the
> start), but its contents are not well-defined:
> Depending on some other variables, it might be either a count in
> words or bytes, and it could refer to either input or output.
> 
> The easiest solution apparently is to remove the confusing output
> and let the reader figure out the state from the other variables.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
