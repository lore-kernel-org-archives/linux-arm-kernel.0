From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 5 Jun 2018 14:39:16 +0200
Subject: [PATCH] arm: cntvoff: Add a function definition when !SMP
In-Reply-To: <20180605064944.524bblnhhkwhr34i@verge.net.au>
References: <20180528084016.9271-1-maxime.ripard@bootlin.com>
 <20180604162603.j3rtfbg3hqhast6p@flea>
 <20180605064944.524bblnhhkwhr34i@verge.net.au>
Message-ID: <20180605123916.s4qt6fsaxuphw6kl@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 08:49:44AM +0200, Simon Horman wrote:
> On Mon, Jun 04, 2018 at 06:26:03PM +0200, Maxime Ripard wrote:
> > On Mon, May 28, 2018 at 10:40:16AM +0200, Maxime Ripard wrote:
> > > The secure_cntvoff_init function is only compiled if CONFIG_SMP is set to
> > > true. However, that will lead to linking errors if one uses this function
> > > without an ifdef CONFIG_SMP guard, which isn't ideal.
> > > 
> > > Provide a dumb implementation when CONFIG_SMP is false so that we don't end
> > > up with a compilation error on our hands.
> 
> What are the errors that this patch fixes?

There's a linking error when CONFIG_SMP is not enabled since the
function will not be implemented anywhere.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180605/716b6265/attachment-0001.sig>
