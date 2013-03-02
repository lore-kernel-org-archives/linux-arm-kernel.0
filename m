From: grant.likely@secretlab.ca (Grant Likely)
Date: Sat, 02 Mar 2013 20:10:04 +0000
Subject: [PATCH 3/3] ARM: S3C24XX: handle s3c2412 eints using new
 infrastructure
In-Reply-To: <CACRpkdZ5dxyXhrNUJDEzPoDOGRn_50ZuaHW4ZpguSyApQvh7hw@mail.gmail.com>
References: <201302120102.03511.heiko@sntech.de>
 <201302120105.45608.heiko@sntech.de>
 <CACRpkdZ5dxyXhrNUJDEzPoDOGRn_50ZuaHW4ZpguSyApQvh7hw@mail.gmail.com>
Message-ID: <20130302201004.95D033E20E9@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Feb 2013 15:48:52 +0100, Linus Walleij <linus.walleij@linaro.org> wrote:
> On Tue, Feb 12, 2013 at 1:05 AM, Heiko St??bner <heiko@sntech.de> wrote:
> 
> > The s3c2412 handles the eints 0 to 3 different than all the other SoCs
> > of the 24xx range. These eints must be acked and masked in the regular
> > bits as well as the bits 0 to 3 of the eint registers, which are unused
> > on the other SoCs.
> >
> > This of course can be realized using the new infrastructure with the
> > eint bits in the main register being the parent interrupts of the
> > same bits in the eint register.
> >
> > The s3c2412 therefore gets its own IRQ_EINT0 to 4 constants that
> > reside in the newly created gap before IRQ_EINT4. gpio-samsung, as the
> > only user of these is modified to return the correct values when
> > handling gpio_to_irq requests on s3c2412 based machines.
> >
> > Due to lack of hardware this is compile tested only, but should
> > hopefully work as intended.
> >
> > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> 
> We definately need an ACK from some Samsung maintainer for
> this patch...

Pish, I'm not taking this. It's all arch/arm code with a 6 line
drivers/gpio change. Instead:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

g.
