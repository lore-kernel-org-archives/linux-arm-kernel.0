From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Thu, 24 Nov 2011 07:40:18 +0100
Subject: [PATCH] ARM: mach-orion5x: Use hex2bin that is present in kernel
 lib
In-Reply-To: <1322058417.2472.9.camel@localhost.localdomain>
References: <1322058417.2472.9.camel@localhost.localdomain>
Message-ID: <20111124064018.GD795@wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 23, 2011 at 04:26:57PM +0200, plaes at plaes.org wrote:

> Hey!

Hello!


> I noticed there was some duplicate code under arm/mach-orion5x directory
> so I ended up with a patch that uses existing library function present
> in kernel code.
> 
> I regretfully have to admit that this patch is NOT even compile-tested,
> but I hope that it still useful in case it happens to break something...
>
> [...]
>
>  	for (i = 0; i < 6; i++)	{
> -		int byte;
> -
> -		byte = dns323_parse_hex_byte(mac_page + (i * 3));
> -		if (byte < 0) {
> +		if (hex2bin(addr[i], mac_page + (i * 3), 2))
>  			goto error_fail;

I don't think that this does what you think it does...


thanks,
Lennert
