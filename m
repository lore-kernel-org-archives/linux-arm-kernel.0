From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 9 Feb 2012 23:41:08 +0000
Subject: [PATCH 6/9] serial: samsung: Add support for EXYNOS5250
In-Reply-To: <CAH9JG2XE7nj1je9SYQ=zJKo0_P5Sx_ruZrDjtpnsL0Qtvzb+_Q@mail.gmail.com>
References: <1328024354-4277-1-git-send-email-kgene.kim@samsung.com>
 <1328024354-4277-7-git-send-email-kgene.kim@samsung.com>
 <CAH9JG2XE7nj1je9SYQ=zJKo0_P5Sx_ruZrDjtpnsL0Qtvzb+_Q@mail.gmail.com>
Message-ID: <201202092341.08981.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 February 2012, Kyungmin Park wrote:
> >
> > diff --git a/drivers/tty/serial/samsung.c b/drivers/tty/serial/samsung.c
> > index 3b07fb9..c55e5fb 100644
> > --- a/drivers/tty/serial/samsung.c
> > +++ b/drivers/tty/serial/samsung.c
> > @@ -1594,7 +1594,7 @@ static struct s3c24xx_serial_drv_data
> > s5pv210_serial_drv_data = {
> >  #endif
> >
> >  #if defined(CONFIG_CPU_EXYNOS4210) || defined(CONFIG_SOC_EXYNOS4212) || \
> > -     defined(CONFIG_SOC_EXYNOS4412)
> > +     defined(CONFIG_SOC_EXYNOS4412) || defined(CONFIG_SOC_EXYNOS5250)
> I think you can make it simple just use "#ifdef CONFIG_ARCH_EXYNOS "

Or you could just remove all the #ifdef. Most drivers just register
for all devices that they support, even if you know which one to expect.

	Arnd
