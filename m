From: heiko@sntech.de (Heiko =?iso-8859-1?q?St=FCbner?=)
Date: Fri, 15 Feb 2013 16:26:35 +0100
Subject: [PATCH 3/3] ARM: S3C24XX: handle s3c2412 eints using new
 infrastructure
In-Reply-To: <CACRpkdZ5dxyXhrNUJDEzPoDOGRn_50ZuaHW4ZpguSyApQvh7hw@mail.gmail.com>
References: <201302120102.03511.heiko@sntech.de>
 <201302120105.45608.heiko@sntech.de>
 <CACRpkdZ5dxyXhrNUJDEzPoDOGRn_50ZuaHW4ZpguSyApQvh7hw@mail.gmail.com>
Message-ID: <201302151626.36805.heiko@sntech.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 15. Februar 2013, 15:48:52 schrieb Linus Walleij:
> On Tue, Feb 12, 2013 at 1:05 AM, Heiko St?bner <heiko@sntech.de> wrote:
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

Kukjin has already included these patches [0], but did only reply to
the previous series (which handles s3c2440 specific stuff) that he
included both [1].


Heiko


[0] http://git.kernel.org/?p=linux/kernel/git/kgene/linux-samsung.git;a=shortlog;h=refs/heads/next/irq-s3c24xx-2
[1] http://permalink.gmane.org/gmane.linux.kernel.samsung-soc/16074
