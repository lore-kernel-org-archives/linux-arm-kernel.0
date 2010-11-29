From: kgene.kim@samsung.com (Kukjin Kim)
Date: Mon, 29 Nov 2010 19:15:03 +0900
Subject: [PATCH v3] ARM: s3c2442: Setup gpio {set,get}_pull callbacks
In-Reply-To: <201011291156.09784.anarsoul@gmail.com>
References: <1289030074-5233-1-git-send-email-anarsoul@gmail.com>
	<1289247983-20747-1-git-send-email-anarsoul@gmail.com>
	<201011291156.09784.anarsoul@gmail.com>
Message-ID: <000201cb8fae$4d61fd20$e825f760$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vasily Khoruzhick wrote:
> 
> On Monday 08 November 2010 22:26:23 Vasily Khoruzhick wrote:
> > Currently the {set,get}_pull callbacks of the s3c24xx_gpiocfg_default
> > structure are initalized via s3c_gpio_{get,set}pull_1up. This results in a
> > linker error when compiling kernel for s3c2442:
> >
> > arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f4): undefined reference to
> > `s3c_gpio_getpull_1up'
> > arch/arm/plat-s3c24xx/built-in.o:(.data+0x13f8): undefined reference to
> > `s3c_gpio_setpull_1up'
> >
> > The s3c2442 has pulldowns instead of pullups compared to the s3c2440.
> > The method of controlling them is the same though.
> > So this patch modifies the existing s3c_gpio_{get,set}pull_1up helper
> > functions to take an additional parameter deciding whether the pin has a
> > pullup or pulldown. The s3c_gpio_{get,set}pull_1{down,up} functions then
> > wrap that functions passing either S3C_GPIO_PULL_UP or S3C_GPIO_PULL_DOWN.
> >
> > Furthermore this patch sets up the s3c24xx_gpiocfg_default.{get,set}_pull
> > fields in the s3c2442 cpu init function to the new pulldown helper
> > functions.
> >
> > Based on patch from "Lars-Peter Clausen" <lars@metafoo.de>
> 
> Hi there,
> 
> Can any samsung-soc maintainer review/merge this patch?
> 
> I should admit that merging patches through samsung maintainers became pretty
> impossible - response latency is about 1 month, some patches (not mine) are
> still pending. I've sent first version of this patch on 6th of November, few
> weeks of standby - and we'll get 2.6.37 with broken s3c2442 support. Yeah, I
> know that maintainers are living people too, and they need to pay attention
> to
> real life, work, family, etc, but now merging some samsung-soc-related patch
> is really painfull and slow proccess, and it would be nice if it could be
> somehow improved.
> 
Hi,

Actually, I didn't get your patch through my e-mail.
Maybe you missed my e-mail in Cc at that time and I missed your patch in mailing list.
Could you please re-send it so that can get the patch via e-mail?

Now, thanks for adding me, will review...

I think, we have some time to fix it for 37, so don't worry about broken 37-stable.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
