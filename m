From: baruch@tkos.co.il (Baruch Siach)
Date: Thu, 25 Jan 2018 11:52:24 +0200
Subject: [PATCH 3/4] arm64: add support for i.MX8M EVK board
In-Reply-To: <20180124144751.jt6y3uayhplzbjxf@sapphire.tkos.co.il>
References: <20180117183244.28303-1-l.stach@pengutronix.de>
 <20180117183244.28303-3-l.stach@pengutronix.de>
 <20180124144751.jt6y3uayhplzbjxf@sapphire.tkos.co.il>
Message-ID: <20180125095224.npweaunijmesbmhs@tarshish>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lucas,

On Wed, Jan 24, 2018 at 04:47:51PM +0200, Baruch Siach wrote:
> On Wed, Jan 17, 2018 at 07:32:43PM +0100, Lucas Stach wrote:
> > This is the evaluation kit board for the i.MX8M. The current level of
> > support yields a working console and is able to boot userspace from
> > SD card or Network.
> > 
> > Signed-off-by: Lucas Stach <l.stach@pengutronix.de>
> > ---
> >  arch/arm64/boot/dts/nxp/Makefile       |   3 +
> >  arch/arm64/boot/dts/nxp/imx8mq-evk.dts | 287 +++++++++++++++++++++++++++++++++
> >  2 files changed, 290 insertions(+)
> >  create mode 100644 arch/arm64/boot/dts/nxp/Makefile
> >  create mode 100644 arch/arm64/boot/dts/nxp/imx8mq-evk.dts
> > 
> > diff --git a/arch/arm64/boot/dts/nxp/Makefile b/arch/arm64/boot/dts/nxp/Makefile
> > new file mode 100644
> > index 000000000000..1aebb1f16708
> > --- /dev/null
> > +++ b/arch/arm64/boot/dts/nxp/Makefile
> > @@ -0,0 +1,3 @@
> > +# SPDX-License-Identifier: GPL-2.0
> > +
> > +dtb-$(CONFIG_SOC_IMX8MQ) += imx8m-evk.dtb
> 
> Typo, should be imx8mq-evk.dtb. Without this fix I'm getting:
> 
> make[2]: *** No rule to make target 'arch/arm64/boot/dts/nxp/imx8m-evk.dtb', needed by '__build'.  Stop.

With this fix and CONFIG_CPU_IDLE disabled:

Tested-by: Baruch Siach <baruch@tkos.co.il>

On i.MX8MQ EVK rev B3.

Thanks,
baruch

-- 
     http://baruch.siach.name/blog/                  ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch at tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
