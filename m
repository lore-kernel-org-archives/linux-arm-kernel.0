From: marex@denx.de (Marek Vasut)
Date: Fri, 20 Nov 2015 22:05:33 +0100
Subject: [PATCH V2 2/2] ARM: dts: imx6q: add Novena board
In-Reply-To: <CAOMZO5C_mKO4c5Wn9Vcvgg3k5tqS9aXajumdoZ_MiYb5r2tLSg@mail.gmail.com>
References: <1447840120-8513-2-git-send-email-marex@denx.de>
 <1448052365-4987-1-git-send-email-marex@denx.de>
 <CAOMZO5C_mKO4c5Wn9Vcvgg3k5tqS9aXajumdoZ_MiYb5r2tLSg@mail.gmail.com>
Message-ID: <201511202205.33275.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 20, 2015 at 09:58:39 PM, Fabio Estevam wrote:
> On Fri, Nov 20, 2015 at 6:46 PM, Marek Vasut <marex@denx.de> wrote:
> > From: Sean Cross <xobs@kosagi.com>
> > 
> > Novena is an open-hardware laptop/desktop/bare board.
> > 
> > See http://www.kosagi.com/w/index.php?title=Novena_Main_Page
> > 
> > Signed-off-by: Sean Cross <xobs@kosagi.com>
> > Cc: Fabio Estevam <fabio.estevam@freescale.com>
> > Cc: Lucas Stach <l.stach@pengutronix.de>
> > Cc: Sean Cross <xobs@kosagi.com>
> > Cc: Shawn Guo <shawnguo@kernel.org>
> 
> Looks good:
> Reviewed-by: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Two minor comments:
> > +&fec {
> > +       pinctrl-names = "default";
> > +       pinctrl-0 = <&pinctrl_enet_novena>;
> > +       phy-mode = "rgmii";
> > +       phy-reset-gpios = <&gpio3 23 GPIO_ACTIVE_HIGH>;
> > +       mac-address = [00 00 00 00 00 00];
> 
> This mac-address entry could be removed, right?
> 
> > +&ssi1 {
> > +       fsl,mode = "i2s-slave";
> 
> Please remove this one. It is no longer used.

Yeah, and I should've dropped the spidev node altogether.

Best regards,
Marek Vasut
