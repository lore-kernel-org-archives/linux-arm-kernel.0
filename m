From: michael@amarulasolutions.com (Michael Trimarchi)
Date: Sat, 20 Feb 2016 18:18:23 +0100
Subject: [PATCH 1/4] ARM: dts: imx6ul: Add flexcan1 and flexcan2 support
In-Reply-To: <CAOMZO5Bk_ZMhYzFLRFNK2TQvK4KHuj62AM_6uF-m-P1kJupTHQ@mail.gmail.com>
References: <1455963652-24618-1-git-send-email-michael@amarulasolutions.com>
 <1455963652-24618-2-git-send-email-michael@amarulasolutions.com>
 <CAOMZO5Bk_ZMhYzFLRFNK2TQvK4KHuj62AM_6uF-m-P1kJupTHQ@mail.gmail.com>
Message-ID: <20160220171816.GA24064@panicking>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio

On Sat, Feb 20, 2016 at 12:02:51PM -0200, Fabio Estevam wrote:
> On Sat, Feb 20, 2016 at 8:20 AM, Michael Trimarchi
> <michael@amarulasolutions.com> wrote:
> 
> > +
> > +                               flexcan1: can at 02090000 {
> > +                                       compatible = "fsl,imx6ul-flexcan", "fsl,imx6q-flexcan";
> > +                                       reg = <0x02090000 0x4000>;
> > +                                       interrupts = <GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>;
> > +                                       clocks = <&clks IMX6UL_CLK_CAN1_IPG>,
> > +                                                <&clks IMX6UL_CLK_CAN1_SERIAL>;
> > +                                       clock-names = "ipg", "per";
> > +                                       stop-mode = <&gpr 0x10 1 0x10 17>;
> 
> This 'stop-mode' property is not handled in mainline, only in NXP
> kernel, so I suggest to drop this.

ok. Can you point me out to a driver in freescale source that use it?

Michael

-- 
| Michael Nazzareno Trimarchi                     Amarula Solutions BV |
| COO  -  Founder                                      Cruquiuskade 47 |
| +31(0)851119172                                 Amsterdam 1018 AM NL |
|                  [`as] http://www.amarulasolutions.com               |
