From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 23 Dec 2015 18:24:33 +0800
Subject: [PATCH 00/24] crypto: atmel-aes: global rework of the driver
In-Reply-To: <cover.1450366831.git.cyrille.pitchen@atmel.com>
References: <cover.1450366831.git.cyrille.pitchen@atmel.com>
Message-ID: <20151223102433.GA1205@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 17, 2015 at 05:48:31PM +0100, Cyrille Pitchen wrote:
> Hi all,
> 
> this series of patches is a global rework of the Atmel driver. Some
> patches improve the performances whereas others fix some bugs like
> the counter overflow in CTR mode.
> 
> It also updates some part of the code to make them more generic. For
> instance the crypto request queue management supports both async block
> cipher and AEAD requests, which allows us to add support the the GCM
> mode. The support of the GCM mode is only available on sama5d4 and later.
> 
> This series is based on linux-next and was tested on sama5d2, sama5d3 and
> sama5d4 boards. The driver implementation was validated using the tcrypt
> module running modes:
> - 10: ecb(aes), cbc(aes), ctr(aes), rfc3686(ctr(aes))
> - 35: gcm(aes)
> 
> tcrypt speed test was run with modes:
> - 211: rfc4106(gcm(aes)), gcm(aes)
> - 500: ecb(aes), cbc(aes), ctr(aes), cfb(aes), ofc(aes), rfc3686(ctr(aes))
> 
> Finally iperf was run for at least 5 mins over an IPSEC/L2TP tunnel using
> the rfc4106(gcm(aes)) cipher suite.

All applied.  Thanks!
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
