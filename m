From: kgene.kim@samsung.com (Kukjin Kim)
Date: Sat, 02 Oct 2010 20:16:48 +0900
Subject: [PATCH 06/27] ARM: S5P64X0: 2nd Change to using
	s3c_gpio_cfgpin_range()
In-Reply-To: <AANLkTimBW5udfRN=0=ZHoAwkn+2ewyUX-0B5jLfrsT+i@mail.gmail.com>
References: <1285934724-5007-1-git-send-email-kgene.kim@samsung.com>
	<1285934724-5007-7-git-send-email-kgene.kim@samsung.com>
	<AANLkTimBW5udfRN=0=ZHoAwkn+2ewyUX-0B5jLfrsT+i@mail.gmail.com>
Message-ID: <014b01cb6223$510dafe0$f3290fa0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kyungmin Park wrote:
> 
> Hi,
> 
Hi :-)

> On Fri, Oct 1, 2010 at 9:05 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > This patch changes the code setting ranges of GPIO pins in mach-s5p64x0
using
> > s3c_gpio_cfgpin() to use the recently introduced
s3c_gpio_cfgpin_range().
> > NOTE: This is for missed things from the previous patch.
> >
> > Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> > ---
> > ?arch/arm/mach-s5p64x0/dev-spi.c ? ?| ? 24 ++++++++++++------------
> > ?arch/arm/mach-s5p64x0/setup-i2c0.c | ? ?6 ++----
> > ?arch/arm/mach-s5p64x0/setup-i2c1.c | ? ?6 ++----
> > ?3 files changed, 16 insertions(+), 20 deletions(-)
> >
> > diff --git a/arch/arm/mach-s5p64x0/dev-spi.c
b/arch/arm/mach-s5p64x0/dev-spi.c
> > index 5b69ec4..be64fee 100644
> > --- a/arch/arm/mach-s5p64x0/dev-spi.c
> > +++ b/arch/arm/mach-s5p64x0/dev-spi.c
> > @@ -39,20 +39,18 @@ static char *s5p64x0_spi_src_clks[] = {
> > ?*/
> > ?static int s5p6440_spi_cfg_gpio(struct platform_device *pdev)
> > ?{
> > + ? ? ? unsigned int base;
> > +
> > ? ? ? ?switch (pdev->id) {
> > ? ? ? ?case 0:
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6440_GPC(0), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6440_GPC(1), S3C_GPIO_SFN(2));
> > - ? ? ? ? ? ? ? s3c_gpio_cfgpin(S5P6440_GPC(2), S3C_GPIO_SFN(2));
> > + ? ? ? ? ? ? ? base = S5P6440_GPC(0);
> > ? ? ? ? ? ? ? ?s3c_gpio_setpull(S5P6440_GPC(0), S3C_GPIO_PULL_UP);
> > ? ? ? ? ? ? ? ?s3c_gpio_setpull(S5P6440_GPC(1), S3C_GPIO_PULL_UP);
> > ? ? ? ? ? ? ? ?s3c_gpio_setpull(S5P6440_GPC(2), S3C_GPIO_PULL_UP);
> 
> Also make a wrapper, s3c_gpio_cfgrange_pullup, then you can also
> remove above codes.
> There's lots of codes use PULL_UP as default pin setup.
> 
Thanks for your suggestion.
Ok..will consider it.

(snip)

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
