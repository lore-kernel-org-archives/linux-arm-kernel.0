From: horms@verge.net.au (Simon Horman)
Date: Tue, 5 Jun 2018 08:49:44 +0200
Subject: [PATCH] arm: cntvoff: Add a function definition when !SMP
In-Reply-To: <20180604162603.j3rtfbg3hqhast6p@flea>
References: <20180528084016.9271-1-maxime.ripard@bootlin.com>
 <20180604162603.j3rtfbg3hqhast6p@flea>
Message-ID: <20180605064944.524bblnhhkwhr34i@verge.net.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 04, 2018 at 06:26:03PM +0200, Maxime Ripard wrote:
> On Mon, May 28, 2018 at 10:40:16AM +0200, Maxime Ripard wrote:
> > The secure_cntvoff_init function is only compiled if CONFIG_SMP is set to
> > true. However, that will lead to linking errors if one uses this function
> > without an ifdef CONFIG_SMP guard, which isn't ideal.
> > 
> > Provide a dumb implementation when CONFIG_SMP is false so that we don't end
> > up with a compilation error on our hands.

What are the errors that this patch fixes?

> > 
> > Cc: Olof Johansson <olof@lixom.net>
> > Cc: Myl?ne Josserand <mylene.josserand@bootlin.com>
> > Cc: Simon Horman <horms@verge.net.au>
> > Cc: Magnus Damm <magnus.damm@gmail.com>
> > Fixes: cad160ed0a94 ("ARM: shmobile: Convert file to use cntvoff")
> > Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>
> 
> Ping?
> 
> Maxime
> 
> -- 
> Maxime Ripard, Bootlin (formerly Free Electrons)
> Embedded Linux and Kernel engineering
> https://bootlin.com
