From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Apr 2010 10:01:14 +0100
Subject: [PATCH] atmel_serial: Atmel RS485 support v2
In-Reply-To: <4BBD8C9D.3070401@evidence.eu.com>
References: <4BB053C4.7050700@evidence.eu.com>
	<4BB10304.6090006@bluewatersys.com>
	<4BB1BF49.2000609@evidence.eu.com>
	<4BB252E3.3030703@bluewatersys.com>
	<4BBD8C9D.3070401@evidence.eu.com>
Message-ID: <20100408090114.GA31407@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 08, 2010 at 09:58:21AM +0200, Claudio Scordino wrote:
> diff --git a/arch/arm/include/asm/ioctls.h b/arch/arm/include/asm/ioctls.h
> index a91d8a1..82f2177 100644
> --- a/arch/arm/include/asm/ioctls.h
> +++ b/arch/arm/include/asm/ioctls.h
> @@ -70,6 +70,8 @@
>  #define TIOCGICOUNT	0x545D	/* read serial port inline interrupt counts */
>  #define FIOQSIZE	0x545E
>  
> +#define TIOCSRS485	0x5461

Why are you only supporting half the interface?

#define TIOCGRS485      0x542E
#define TIOCSRS485      0x542F

is what is in include/asm-generic/ioctls.h - and it would be a good idea
to use the same numbering as the generic file rather than creating yet
more divergence.
