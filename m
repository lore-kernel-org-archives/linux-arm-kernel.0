From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 18 Dec 2017 10:24:37 +0100
Subject: [linux-sunxi] [PATCH v3 2/3] dt-bindings: media: Add Allwinner
 V3s Camera Sensor Interface (CSI)
In-Reply-To: <20171218164921.227b82349c778283f5e5eba8@magewell.com>
References: <1510558344-45402-1-git-send-email-yong.deng@magewell.com>
 <CAGb2v67JhMfba8Ao7WyrYikkxvTxX8WaBRqu3GkrhOCWndresg@mail.gmail.com>
 <20171218164921.227b82349c778283f5e5eba8@magewell.com>
Message-ID: <20171218092437.ksczam5h7hirmpcv@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 18, 2017 at 04:49:21PM +0800, Yong wrote:
> > > +               compatible = "allwinner,sun8i-v3s-csi";
> > > +               reg = <0x01cb4000 0x1000>;
> > > +               interrupts = <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
> > > +               clocks = <&ccu CLK_BUS_CSI>,
> > > +                        <&ccu CLK_CSI1_SCLK>,
> > 
> > CSI also has an MCLK. Do you need that one?
> 
> MCLK is not needed if the front end is not a sensor (like adv7611).
> I will add it as an option.

I guess this should always be needed then. And the driver will make
the decision to enable it or not.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20171218/010dbb66/attachment-0001.sig>
