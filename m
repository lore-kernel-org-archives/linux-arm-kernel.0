From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Sep 2011 19:28:43 +0800
Subject: [PATCH v2 3/3] net/fec: add imx6q enet support
In-Reply-To: <CAOMZO5CzVj=sMhD24H0OQKqp2Z0XtHhkTX=kEp5oshKqTAJ4oA@mail.gmail.com>
References: <1316603432-20032-1-git-send-email-shawn.guo@linaro.org>
	<1316603432-20032-4-git-send-email-shawn.guo@linaro.org>
	<CAOMZO5CzVj=sMhD24H0OQKqp2Z0XtHhkTX=kEp5oshKqTAJ4oA@mail.gmail.com>
Message-ID: <20110921112842.GE28907@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 21, 2011 at 08:07:42AM -0300, Fabio Estevam wrote:
> On Wed, Sep 21, 2011 at 8:10 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> ...
> > diff --git a/drivers/net/ethernet/freescale/Kconfig b/drivers/net/ethernet/freescale/Kconfig
> > index 4dbe41f..1cf6716 100644
> > --- a/drivers/net/ethernet/freescale/Kconfig
> > +++ b/drivers/net/ethernet/freescale/Kconfig
> > @@ -7,7 +7,7 @@ config NET_VENDOR_FREESCALE
> > ? ? ? ?default y
> > ? ? ? ?depends on FSL_SOC || QUICC_ENGINE || CPM1 || CPM2 || PPC_MPC512x || \
> > ? ? ? ? ? ? ? ? ? M523x || M527x || M5272 || M528x || M520x || M532x || \
> > - ? ? ? ? ? ? ? ? ?IMX_HAVE_PLATFORM_FEC || MXS_HAVE_PLATFORM_FEC || \
> > + ? ? ? ? ? ? ? ? ?ARCH_MXC || ARCH_MXS || \
> 
> Do you need to get rid of  IMX_HAVE_PLATFORM_FEC and MXS_HAVE_PLATFORM_FEC?
> 
Yes, I do.  We are moving to device tree, so the Kconfig symbol
IMX_HAVE_PLATFORM_FEC makes no sense any more, as the platform device
registration will be done by DT core according whether there is a FEC
node in device tree or not.

> By doing that you are selecting FEC for SoCs that don?t have this
> module such as MX1/MX21/MX31.
> 
No.  By doing that, FEC will not be selected for any SoCs by default.
You need to select it explicitly if you are building a platform with
FEC support.

-- 
Regards,
Shawn
