From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 1 Feb 2010 19:09:06 +0000
Subject: [PATCH] Modify PL031 for Nomadik and U8500
In-Reply-To: <1265032400-28558-1-git-send-email-linus.walleij@stericsson.com>
References: <1265032400-28558-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20100201190906.GA4667@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 01, 2010 at 02:53:19PM +0100, Linus Walleij wrote:
> Note: I cannot find any in-kernel users of this driver, no
> platforms have it in their defconfig. But for mach-nomadik and
> mach-u8500 we will certainly use this driver. Patches to make use
> of it will follow.

Versatile/Realview platforms have this; I don't know why it was never
added to their defconfigs, but it's something I regularly build.

>  static struct amba_id pl031_ids[] __initdata = {
>  	{
>  		.id = 0x00041031,
> -		.mask = 0x000fffff,
> +		.mask = 0x00ffffff,

Why is this increasing the mask?
