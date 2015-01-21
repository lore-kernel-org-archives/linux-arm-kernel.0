From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Wed, 21 Jan 2015 09:17:48 +0100
Subject: [PATCH 2/8] soc: Add MediaTek pericfg controller support
In-Reply-To: <20150120161555.GH15924@leverpostej>
References: <1421747231-554-1-git-send-email-s.hauer@pengutronix.de>
 <1421747231-554-3-git-send-email-s.hauer@pengutronix.de>
 <20150120161555.GH15924@leverpostej>
Message-ID: <20150121081748.GC12209@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 20, 2015 at 04:15:55PM +0000, Mark Rutland wrote:
> > +
> > +	pericfg: pericfg at 10003000 {
> > +		#reset-cells = <1>;
> > +		#clock-cells = <1>;
> > +		compatible = "mediatek,mt8135-pericfg";
> > +		reg = <0 0x10003000 0 0x1000>;
> > +	};
> 
> This looks identical to the infracfg (same address too). Is that
> deliberate?

Both controllers indeed control clocks and resets, but with a different
register layout, so the nodes really look identical. I'll change the
address to the real address of the MT8135 pericfg though to make the
example more realistic.

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
