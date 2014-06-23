From: mpa@pengutronix.de (Markus Pargmann)
Date: Mon, 23 Jun 2014 11:54:43 +0200
Subject: [PATCH 0/7] ARM: dts: ssi device node updates
In-Reply-To: <20140620123337.GI28225@dragon>
References: <1402995995-15098-1-git-send-email-mpa@pengutronix.de>
 <20140620123337.GI28225@dragon>
Message-ID: <20140623095443.GE32450@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Fri, Jun 20, 2014 at 08:33:38PM +0800, Shawn Guo wrote:
> On Tue, Jun 17, 2014 at 11:06:28AM +0200, Markus Pargmann wrote:
> > This series cleans up some old or unnecessary properties from the dts files.
> > 
> > Patch 1 removes an enabled ssi unit that is not used.
> 
> Instead of holding the whole series by waiting ACK from ventana board
> maintainer on the first patch, I choose to keep the ssi node and remove
> fsl,mode property.  The ssi node can be removed later in another patch
> after board maintainer confirms.
> 
> > 
> > Patch 2 adds ssi DMA properties based on the previous definiton of
> > fsl,ssi-dma-events for imx50.
> > 
> > Patches 3 and 4 remove the old non-generic fsl,ssi-dma-events property. The
> > generic dmas property is still present and used.
> > 
> > Patch 5,6 and 7 remove the fsl,mode properties for ssi units that are
> > connected with sgtl5000 cards. The sgtl5000 already configures the connection
> > between codec and CPU DAI correctly, so we don't need fsl,mode here.
> 
> There are some a number of new boards on my imx/dt branch across
> different i.MX series.  Since the last 3 patches are all about board
> level files, I just squashed them and made the same change for those
> new boards in there.

Okay thanks.

> 
> Also, I updated the patch subject a little bit, primarily on prefix.
> And the last one should be about audio cards, not only sgtl5000.  So in
> all, the new summary looks like the following.

Oh right, I overlooked that I also changed it for another sound card.

Thanks,

Markus

> 
> Markus Pargmann (4):
>   ARM: dts: imx50: add ssi dma properties
>   ARM: dts: imx5: remove fsl,ssi-dma-events
>   ARM: dts: imx6qdl: remove fsl,ssi-dma-events
>   ARM: dts: imx: remove ssi fsl,mode for audio cards
> 
>  arch/arm/boot/dts/imx25-eukrea-mbimxsd25-baseboard.dts | 1 -
>  arch/arm/boot/dts/imx25-pdk.dts                        | 1 -
>  arch/arm/boot/dts/imx27-eukrea-mbimxsd27-baseboard.dts | 1 -
>  arch/arm/boot/dts/imx27-phytec-phycore-som.dtsi        | 1 -
>  arch/arm/boot/dts/imx35-eukrea-mbimxsd35-baseboard.dts | 1 -
>  arch/arm/boot/dts/imx50.dtsi                           | 8 ++++++--
>  arch/arm/boot/dts/imx51-babbage.dts                    | 1 -
>  arch/arm/boot/dts/imx51-eukrea-mbimxsd51-baseboard.dts | 1 -
>  arch/arm/boot/dts/imx51.dtsi                           | 3 ---
>  arch/arm/boot/dts/imx53-m53evk.dts                     | 1 -
>  arch/arm/boot/dts/imx53-mba53.dts                      | 1 -
>  arch/arm/boot/dts/imx53-qsb-common.dtsi                | 1 -
>  arch/arm/boot/dts/imx53-tx53.dtsi                      | 1 -
>  arch/arm/boot/dts/imx53-voipac-bsb.dts                 | 1 -
>  arch/arm/boot/dts/imx53.dtsi                           | 3 ---
>  arch/arm/boot/dts/imx6dl-riotboard.dts                 | 1 -
>  arch/arm/boot/dts/imx6q-gw5400-a.dts                   | 1 -
>  arch/arm/boot/dts/imx6qdl-gw52xx.dtsi                  | 1 -
>  arch/arm/boot/dts/imx6qdl-gw53xx.dtsi                  | 1 -
>  arch/arm/boot/dts/imx6qdl-gw54xx.dtsi                  | 2 --
>  arch/arm/boot/dts/imx6qdl-nitrogen6x.dtsi              | 1 -
>  arch/arm/boot/dts/imx6qdl-sabrelite.dtsi               | 1 -
>  arch/arm/boot/dts/imx6qdl-sabresd.dtsi                 | 1 -
>  arch/arm/boot/dts/imx6qdl-tx6.dtsi                     | 1 -
>  arch/arm/boot/dts/imx6qdl-wandboard.dtsi               | 1 -
>  arch/arm/boot/dts/imx6qdl.dtsi                         | 3 ---
>  arch/arm/boot/dts/imx6sl-evk.dts                       | 1 -
>  27 files changed, 6 insertions(+), 35 deletions(-)
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140623/fea53e1a/attachment.sig>
