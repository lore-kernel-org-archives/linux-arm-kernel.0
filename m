From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Mon, 10 Apr 2017 17:39:03 +0800
Subject: [PATCH 0/7] arm64: marvell: add cryptographic engine support for
 7k/8k
In-Reply-To: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
References: <20170329124432.27457-1-antoine.tenart@free-electrons.com>
Message-ID: <20170410093903.GA8035@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 29, 2017 at 02:44:25PM +0200, Antoine Tenart wrote:
> Hi all,
> 
> This series adds support for the Inside Secure SafeXcel EIP197
> cryptographic engine which can be found on Marvell Armada 7k and 8k
> boards. A new cryptographic engine driver is added, as well as the
> relevant device tree definition for the Armada 7040 DB and 8040 DB
> boards.
> 
> This driver needs two firmwares to work correctly. These firmware are
> usually used for more advanced operations than the ones supported (as of
> now), but we still need them to pass the data to the internal
> cryptographic engine.
> 
> This series was tested in various ways on both the Armada 7040 DB and
> the Armada 8040 DB: using the crypto framework self tests, using tcrypt
> and while performing various transfers with iperf on top of IPsec.
> 
> This series is based on top of v4.11-rc1, and is available on a branch
> (which also contains the PPv2 support for 7k/8k, to ease the process of
> testing IPsec): https://github.com/atenart/linux  v4.11-rc1/7k8k-crypto
> I can rebase if needed.
> 
> Thanks,
> Antoine
> 
> 
> Antoine Tenart (7):
>   Documentation/bindings: Document the SafeXel cryptographic engine
>     driver
>   crypto: inside-secure: add SafeXcel EIP197 crypto engine driver
>   MAINTAINERS: add a maintainer for the Inside Secure crypto driver
>   arm64: marvell: dts: add crypto engine description for 7k/8k
>   arm64: marvell: dts: enable the crypto engine on the Armada 7040 DB
>   arm64: marvell: dts: enable the crypto engine on the Armada 8040 DB
>   arm64: defconfig: enable the Safexcel crypto engine as a module

I have no problems with the crypto bits.

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
