From: manu@bidouilliste.com (Emmanuel Vadot)
Date: Thu, 24 Nov 2016 21:05:09 +0100
Subject: [PATCH] ARM: dts: sunxi: Add num-cs for A20 spi nodes
In-Reply-To: <20161124195517.qrq7briu3pwjnp4n@lukather>
References: <20161122170616.29557-1-manu@bidouilliste.com>
 <20161124195517.qrq7briu3pwjnp4n@lukather>
Message-ID: <20161124210509.be743aae84c26c6c2e666c6e@bidouilliste.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 24 Nov 2016 20:55:17 +0100
Maxime Ripard <maxime.ripard@free-electrons.com> wrote:

> On Tue, Nov 22, 2016 at 06:06:16PM +0100, Emmanuel Vadot wrote:
> > The spi0 controller on the A20 have up to 4 CS (Chip Select) while the
> > others three only have 1.
> > Add the num-cs property to each node.
> > 
> > Signed-off-by: Emmanuel Vadot <manu@bidouilliste.com>
> 
> I don't think we have any code that uses it at the moment. What is the
> rationale behind this patch?
> 
> Thanks!
> Maxime
> 
> -- 
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com

 Hi Maxime,

 If num-cs isn't present nothing prevent to start a transfer with a
non-valid CS pin, resulting in an error.
 num-cs are default property especially made for this and a SPI driver
should try to get the property at probe/attach time.

 Cheers,

-- 
Emmanuel Vadot <manu@bidouilliste.com> <manu@freebsd.org>
