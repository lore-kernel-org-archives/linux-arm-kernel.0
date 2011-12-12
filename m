From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 12 Dec 2011 11:26:34 +0100
Subject: [PATCH 1/7] arm/imx6: add imx6q sabrelite board support
In-Reply-To: <20111212101837.GA16835@b20223-02.ap.freescale.net>
References: <1323661352-10291-1-git-send-email-richard.zhao@linaro.org>
 <1323661352-10291-2-git-send-email-richard.zhao@linaro.org>
 <20111212054053.GD9572@S2100-06.ap.freescale.net>
 <20111212101224.GQ27267@pengutronix.de>
 <20111212101837.GA16835@b20223-02.ap.freescale.net>
Message-ID: <20111212102634.GR27267@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 12, 2011 at 06:18:38PM +0800, Richard Zhao wrote:
> On Mon, Dec 12, 2011 at 11:12:24AM +0100, Sascha Hauer wrote:
> > On Mon, Dec 12, 2011 at 01:40:54PM +0800, Shawn Guo wrote:
> > > 
> > > > +	memory {
> > > > +		reg = <0x10000000 0x40000000>;
> > > > +	};
> > > > +
> > > > +	soc {
> > > > +		aips-bus at 02100000 { /* AIPS2 */
> > > > +			enet at 02188000 {
> > > > +				phy-mode = "rgmii";
> > > > +				local-mac-address = [01 04 9F 01 1B 61];
> > > 
> > > Do we still have no way to figure the mac address from hardware setup
> > > (fuse or something) on sabrelite board?
> > 
> > Even if not, adding hardcoded MAC addresses to the kernel is a no go.
> > This includes devicetree blobs.
> If Shawn agree, I can remove it. I don't feel it usefaull on daily develop work.
> Let user use fec.macaddr.

How useful this is you'll realize when all your collegues end up
with the same MAC address. Just remove it.

Sascha

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
