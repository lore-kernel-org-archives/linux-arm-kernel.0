From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 4 Sep 2017 10:04:15 +0200
Subject: [PATCH v2 1/2] ARM: dts: sun8i: h3: Enable AP6212 WiFi on mmc1
 on Nanopi M1 Plus
In-Reply-To: <495813cc0e2ea09e495bfe14d595b926@aosc.io>
References: <1504283401-4263-1-git-send-email-embed3d@gmail.com>
 <1504283401-4263-2-git-send-email-embed3d@gmail.com>
 <495813cc0e2ea09e495bfe14d595b926@aosc.io>
Message-ID: <20170904080415.ptgjnkjwtdthp7ds@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 02, 2017 at 03:01:57PM +0800, icenowy at aosc.io wrote:
> ? 2017-09-02 00:30?Philipp Rossak ???
> > From: Philipp Rossak <embed3d@gmail.com>
> > 
> > The WiFi side of the AP6212 WiFi/BT combo module is connected to
> > mmc1. There are also GPIOs for enable and interrupts.
> > 
> > Enable WiFi on this board by enabling mmc1 and adding the power
> > sequencing clocks and GPIO, as well as the chip's interrupt line.
> > 
> > Signed-off-by: Philipp Rossak <embed3d@gmail.com>
> > ---
> >  arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts | 25
> > +++++++++++++++++++++++++
> >  1 file changed, 25 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> > b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> > index 6256f55..7d18c35 100644
> > --- a/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> > +++ b/arch/arm/boot/dts/sun8i-h3-nanopi-m1-plus.dts
> > @@ -48,6 +48,13 @@
> > 
> >  	aliases {
> >  		serial1 = &uart3;
> > +		ethernet1 = &sdio_wifi;
> 
> When the Wi-Fi module itself has fixed MAC address, there's
> no need for such an alias.

But the description is also accurate, which is what matters in the DT.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170904/d4405225/attachment-0001.sig>
