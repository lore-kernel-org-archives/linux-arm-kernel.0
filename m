From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Wed, 8 Apr 2015 22:24:46 +0800
Subject: [PATCH 00/10] crypto: at91: add support for SAMA5D4 and fix
 related bugs
In-Reply-To: <1428399911-23325-1-git-send-email-leilei.zhao@atmel.com>
References: <1428399911-23325-1-git-send-email-leilei.zhao@atmel.com>
Message-ID: <20150408142446.GA30541@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 05:45:01PM +0800, Leilei Zhao wrote:
> The series of patches add crypto driver for SAMA5D4 and 
> fix some bugs about Atmel crypto driver:
>  - Add new IP version for AES and SHA.
>  - The spinlock is not initialized before using.
>  - Fix sg list management to avoid crash if there is a zero length sg in list.
>  - The max burst size in DMA configuration is out of range.
>  - The result of AES periodically goes wrong with performance test in OpenSSH.
>  - Fix a hangup issue in driver's internal buffer process.
> 
> The patches were made from herbert/crypto-2.6.git repository, and tested on a
> SAMA5D4EK board and also did regression tests on SAMA5D3EK.
> 
> Leilei Zhao (9):
>   crypto: atmel-aes: add new version
>   crypto: atmel-sha: add new version
>   crypto: atmel-sha: fix sg list management
>   crypto: atmel-sha: initialize spinlock in probe
>   crypto: atmel-sha: correct the max burst size
>   crypto: atmel-tdes: initialize spinlock in probe
>   crypto: atmel-aes: initialize spinlock in probe
>   crypto: atmel-aes: sync the buf used in DMA or CPU
>   crypto: atmel-aes: correct usage of dma_sync_* API
> 
> Ludovic Desroches (1):
>   crypto: atmel-sha: correct the way data are split
> 
>  drivers/crypto/atmel-aes.c  |   24 +++++++++++++++++++-----
>  drivers/crypto/atmel-sha.c  |   35 ++++++++++++++++++++++++-----------
>  drivers/crypto/atmel-tdes.c |    1 +
>  3 files changed, 44 insertions(+), 16 deletions(-)

All applied.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
