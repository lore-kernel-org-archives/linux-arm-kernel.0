From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Sat, 3 Mar 2018 00:33:50 +0800
Subject: [PATCH Resend 0/5] hwrng: stm32 - Improvement for stm32-rng
In-Reply-To: <20180215130312.23612-1-lionel.debieve@st.com>
References: <20180215130312.23612-1-lionel.debieve@st.com>
Message-ID: <20180302163350.GA21579@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 15, 2018 at 02:03:07PM +0100, Lionel Debieve wrote:
> This set of patches add extended functionalities for stm32 rng
> driver.
> Patch #1 includes a reset during probe to avoid any error status
> which can occur during bootup process and keep safe rng integrity.
> 
> Patch #3 adds a new property to manage the clock error detection
> feature which can be disabled on specific target.
> 
> Patch #5 rework the timeout calculation for read value that was
> previously defined based on loop operation and is now based on
> timer.
> 
> Lionel Debieve (5):
>   hwrng: stm32 - add reset during probe
>   dt-bindings: rng: add reset node for stm32
>   hwrng: stm32 - allow disable clock error detection
>   dt-bindings: rng: add clock detection error for stm32
>   hwrng: stm32 - rework read timeout calculation
> 
>  .../devicetree/bindings/rng/st,stm32-rng.txt       |  4 ++
>  drivers/char/hw_random/stm32-rng.c                 | 44 ++++++++++++++--------
>  2 files changed, 32 insertions(+), 16 deletions(-)

All applied.  Thanks.
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
