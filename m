From: mpe@ellerman.id.au (Michael Ellerman)
Date: Wed, 25 Jul 2018 14:20:25 +1000
Subject: [PATCH 1/4] treewide: convert ISO_8859-1 text comments to utf-8
In-Reply-To: <20180724111600.4158975-1-arnd@arndb.de>
References: <20180724111600.4158975-1-arnd@arndb.de>
Message-ID: <87o9ewx7xy.fsf@concordia.ellerman.id.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> Almost all files in the kernel are either plain text or UTF-8
> encoded. A couple however are ISO_8859-1, usually just a few
> characters in a C comments, for historic reasons.
>
> This converts them all to UTF-8 for consistency.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
...
>  drivers/crypto/vmx/ghashp8-ppc.pl             |  12 +-
...
> diff --git a/drivers/crypto/vmx/ghashp8-ppc.pl b/drivers/crypto/vmx/ghashp8-ppc.pl
> index f746af271460..38b06503ede0 100644
> --- a/drivers/crypto/vmx/ghashp8-ppc.pl
> +++ b/drivers/crypto/vmx/ghashp8-ppc.pl
> @@ -129,9 +129,9 @@ $code=<<___;
>  	 le?vperm	$IN,$IN,$IN,$lemask
>  	vxor		$zero,$zero,$zero
>  
> -	vpmsumd		$Xl,$IN,$Hl		# H.loXi.lo
> -	vpmsumd		$Xm,$IN,$H		# H.hiXi.lo+H.loXi.hi
> -	vpmsumd		$Xh,$IN,$Hh		# H.hiXi.hi
> +	vpmsumd		$Xl,$IN,$Hl		# H.lo?Xi.lo
> +	vpmsumd		$Xm,$IN,$H		# H.hi?Xi.lo+H.lo?Xi.hi
> +	vpmsumd		$Xh,$IN,$Hh		# H.hi?Xi.hi
>  
>  	vpmsumd		$t2,$Xl,$xC2		# 1st phase
>  
> @@ -187,11 +187,11 @@ $code=<<___;
>  .align	5
>  Loop:
>  	 subic		$len,$len,16
> -	vpmsumd		$Xl,$IN,$Hl		# H.loXi.lo
> +	vpmsumd		$Xl,$IN,$Hl		# H.lo?Xi.lo
>  	 subfe.		r0,r0,r0		# borrow?-1:0
> -	vpmsumd		$Xm,$IN,$H		# H.hiXi.lo+H.loXi.hi
> +	vpmsumd		$Xm,$IN,$H		# H.hi?Xi.lo+H.lo?Xi.hi
>  	 and		r0,r0,$len
> -	vpmsumd		$Xh,$IN,$Hh		# H.hiXi.hi
> +	vpmsumd		$Xh,$IN,$Hh		# H.hi?Xi.hi
>  	 add		$inp,$inp,r0
>  
>  	vpmsumd		$t2,$Xl,$xC2		# 1st phase

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
