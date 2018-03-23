From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 24 Mar 2018 00:01:49 +0800
Subject: [PATCH 0/3] crypto: inside-secure: improve clock management
In-Reply-To: <20180313164842.20042-1-gregory.clement@bootlin.com>
References: <20180313164842.20042-1-gregory.clement@bootlin.com>
Message-ID: <20180323160149.GC2186@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 13, 2018 at 05:48:39PM +0100, Gregory CLEMENT wrote:
> Hi,
> 
> This short series fixes the way the clocks are used for the SafeXcel
> EIP-197 controller embedded in the Marvell Armada 7K/8K SoCs. On these
> SoCs a second one is needed in order to clock the registers. It was
> not noticed until now because we relied on the bootloader and also
> because the clock driver was wrong.
> 
> Thanks to this fix, it would be possible to fix the clock driver
> without introducing a regression.
> 
> While I was working on the clocks I found a bug in the clock
> management which was fixed with the first patch and should be applied
> to v4.16.

I haven't applied it to the crypto 4.16 tree because your other
patches depend on it and I don't think the issue doesn't seem to
be that severe.

In future it would help if you can avoid such dependencies if you
wish the patches to go in as soon as possible.

> The second patch is a small improvement which is aim for v4.17 as well
> as the last patch.
> 
> Thanks,
> 
> Gregory
> 
> Gregory CLEMENT (3):
>   crypto: inside-secure - fix clock management
>   crypto: inside-secure - improve clock initialization
>   crypto: inside-secure - fix clock resource by adding a register clock
> 
>  .../bindings/crypto/inside-secure-safexcel.txt     |  6 ++-
>  drivers/crypto/inside-secure/safexcel.c            | 47 +++++++++++++++-------
>  drivers/crypto/inside-secure/safexcel.h            |  1 +
>  3 files changed, 38 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
