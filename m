From: David.Laight@ACULAB.COM (David Laight)
Date: Mon, 19 Nov 2018 12:07:16 +0000
Subject: [PATCH] arm64: Explicitly mark 64-bit constant as unsigned long
In-Reply-To: <20181117015456.101222-1-olof@lixom.net>
References: <20181117015456.101222-1-olof@lixom.net>
Message-ID: <51cf0f37dc694a858fcc422763f6ca72@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


From: Olof Johansson
> Sent: 17 November 2018 01:55
...
> -#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xffffffffffffffff
> +#if (SCTLR_EL2_SET ^ SCTLR_EL2_CLEAR) != 0xfffffffffffffffful
>  #error "Inconsistent SCTLR_EL2 set/clear bits"
>  #endif

Wouldn't this be clearer if written:
	#if SCTLR_EL2_SET != ~SCTLR_EL2_CLEAR
which then begs the question of why there are separate 'set' and 'clear' masks.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)
