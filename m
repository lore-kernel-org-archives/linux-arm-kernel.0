From: herbert@gondor.apana.org.au (Herbert Xu)
Date: Tue, 24 Mar 2015 22:32:55 +1100
Subject: [PATCHv2] arm: crypto: Add optimized SHA-256/224
In-Reply-To: <20150323135009.GB820@google.com>
References: <20150316154835.GA31336@google.com>
 <20150323135009.GB820@google.com>
Message-ID: <20150324113255.GD11405@gondor.apana.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 23, 2015 at 01:50:09PM +0000, Sami Tolvanen wrote:
> Add Andy Polyakov's optimized assembly and NEON implementations for
> SHA-256/224.
> 
> The sha256-armv4.pl script for generating the assembly code is from
> OpenSSL commit 2ecd32a1f8f0643ae7b38f59bbaf9f0d6ef326fe.
> 
> Compared to sha256-generic these implementations have the following
> tcrypt speed improvements on Motorola Nexus 6 (Snapdragon 805):
> 
>   bs    b/u      sha256-neon  sha256-asm
>   16    16       x1.32        x1.19
>   64    16       x1.27        x1.15
>   64    64       x1.36        x1.20
>   256   16       x1.22        x1.11
>   256   64       x1.36        x1.19
>   256   256      x1.59        x1.23
>   1024  16       x1.21        x1.10
>   1024  256      x1.65        x1.23
>   1024  1024     x1.76        x1.25
>   2048  16       x1.21        x1.10
>   2048  256      x1.66        x1.23
>   2048  1024     x1.78        x1.25
>   2048  2048     x1.79        x1.25
>   4096  16       x1.20        x1.09
>   4096  256      x1.66        x1.23
>   4096  1024     x1.79        x1.26
>   4096  4096     x1.82        x1.26
>   8192  16       x1.20        x1.09
>   8192  256      x1.67        x1.23
>   8192  1024     x1.80        x1.26
>   8192  4096     x1.85        x1.28
>   8192  8192     x1.85        x1.27
> 
> Where bs refers to block size and b/u to bytes per update.
> 
> Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> Cc: Andy Polyakov <appro@openssl.org>

Your patch didn't make it to the linux-crypto list and therefore
it never got into patchwork.  Can you please find out why and
resend it?

Thanks,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
