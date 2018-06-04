From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Mon, 4 Jun 2018 18:26:03 +0200
Subject: [PATCH] arm: cntvoff: Add a function definition when !SMP
In-Reply-To: <20180528084016.9271-1-maxime.ripard@bootlin.com>
References: <20180528084016.9271-1-maxime.ripard@bootlin.com>
Message-ID: <20180604162603.j3rtfbg3hqhast6p@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 28, 2018 at 10:40:16AM +0200, Maxime Ripard wrote:
> The secure_cntvoff_init function is only compiled if CONFIG_SMP is set to
> true. However, that will lead to linking errors if one uses this function
> without an ifdef CONFIG_SMP guard, which isn't ideal.
> 
> Provide a dumb implementation when CONFIG_SMP is false so that we don't end
> up with a compilation error on our hands.
> 
> Cc: Olof Johansson <olof@lixom.net>
> Cc: Myl?ne Josserand <mylene.josserand@bootlin.com>
> Cc: Simon Horman <horms@verge.net.au>
> Cc: Magnus Damm <magnus.damm@gmail.com>
> Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Ping?

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180604/43cdc1b2/attachment.sig>
