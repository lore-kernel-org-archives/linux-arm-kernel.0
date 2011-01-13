From: grant.likely@secretlab.ca (Grant Likely)
Date: Wed, 12 Jan 2011 20:16:02 -0700
Subject: [PATCH] ARM i.MX SPI driver changes for i.MX53 support
In-Reply-To: <AANLkTimfcxbPq8G_LjO8tz8=nANFkd=5AJYjkTZQyrYG@mail.gmail.com>
References: <1294737713-24015-1-git-send-email-yong.shen@freescale.com>
	<1294737713-24015-2-git-send-email-yong.shen@freescale.com>
	<AANLkTikErJYCNRM1+-hx5Qrk_iW4Ad7fE1iFUODmqK6A@mail.gmail.com>
	<20110113030553.GC1392@angua.secretlab.ca>
	<AANLkTimfcxbPq8G_LjO8tz8=nANFkd=5AJYjkTZQyrYG@mail.gmail.com>
Message-ID: <20110113031602.GD1392@angua.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 13, 2011 at 11:12:07AM +0800, Yong Shen wrote:
> Thanks Grant. I am not asking somebody to merge it right now. I just
> wonder who will take it, since maintainers change from time to time.

Okay.  :-)  For spi stuff, I usually apply it to my tree, unless it
has dependencies on stuff in someone else's tree.  At the very least
spi patches must have either my or David Gibson's ack.

g.

> 
> Yong
> 
> On Thu, Jan 13, 2011 at 11:05 AM, Grant Likely
> <grant.likely@secretlab.ca> wrote:
> > On Thu, Jan 13, 2011 at 11:01:44AM +0800, Yong Shen wrote:
> >> Seems no comments from spi-devel list. This patch is also:
> >> Acked-by: Uwe Kleine-K?nig <u.kleine-koenig@pengutronix.de>
> >>
> >> Who will take this patch into a tree?
> >
> > Patience Yong. ?You only posted it two days ago. ?It takes time for
> > people to notice and respond some times.
> >
> > Normally, I wouldn't pick up a patch in the middle of the merge
> > window, but this is pretty trivial, so I'll bend the rules this time.
> >
> > g.
> >
> >>
> >> Yong
> >>
> >> On Tue, Jan 11, 2011 at 5:21 PM, ?<yong.shen@freescale.com> wrote:
> >> > From: Yong Shen <yong.shen@freescale.com>
> >> >
> >> > 1. Change the Kconfig to include i.MX53
> >> > 2. add devtype entry for i.MX53
> >> >
> >> > Signed-off-by: Yong Shen <yong.shen@freescale.com>
> >> > Acked-by: Sascha Hauer <s.hauer@pengutronix.de>
> >> > ---
> >> > ?drivers/spi/Kconfig ? | ? ?4 ++--
> >> > ?drivers/spi/spi_imx.c | ? ?6 ++++++
> >> > ?2 files changed, 8 insertions(+), 2 deletions(-)
> >> >
> >> > diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> >> > index 78f9fd0..04965e2 100644
> >> > --- a/drivers/spi/Kconfig
> >> > +++ b/drivers/spi/Kconfig
> >> > @@ -153,10 +153,10 @@ config SPI_IMX_VER_0_4
> >> > ? ? ? ?def_bool y if ARCH_MX31
> >> >
> >> > ?config SPI_IMX_VER_0_7
> >> > - ? ? ? def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51
> >> > + ? ? ? def_bool y if ARCH_MX25 || ARCH_MX35 || ARCH_MX51 || ARCH_MX53
> >> >
> >> > ?config SPI_IMX_VER_2_3
> >> > - ? ? ? def_bool y if ARCH_MX51
> >> > + ? ? ? def_bool y if ARCH_MX51 || ARCH_MX53
> >> >
> >> > ?config SPI_IMX
> >> > ? ? ? ?tristate "Freescale i.MX SPI controllers"
> >> > diff --git a/drivers/spi/spi_imx.c b/drivers/spi/spi_imx.c
> >> > index 55a38e2..9b8a733 100644
> >> > --- a/drivers/spi/spi_imx.c
> >> > +++ b/drivers/spi/spi_imx.c
> >> > @@ -747,6 +747,12 @@ static struct platform_device_id spi_imx_devtype[] = {
> >> > ? ? ? ? ? ? ? ?.name = "imx51-ecspi",
> >> > ? ? ? ? ? ? ? ?.driver_data = SPI_IMX_VER_2_3,
> >> > ? ? ? ?}, {
> >> > + ? ? ? ? ? ? ? .name = "imx53-cspi",
> >> > + ? ? ? ? ? ? ? .driver_data = SPI_IMX_VER_0_7,
> >> > + ? ? ? }, {
> >> > + ? ? ? ? ? ? ? .name = "imx53-ecspi",
> >> > + ? ? ? ? ? ? ? .driver_data = SPI_IMX_VER_2_3,
> >> > + ? ? ? }, {
> >> > ? ? ? ? ? ? ? ?/* sentinel */
> >> > ? ? ? ?}
> >> > ?};
> >> > --
> >> > 1.7.1
> >> >
> >> >
> >> >
> >>
> >> _______________________________________________
> >> linux-arm-kernel mailing list
> >> linux-arm-kernel at lists.infradead.org
> >> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
> >
