From: heiko@sntech.de (Heiko Stuebner)
Date: Fri, 06 Jul 2018 15:49:41 +0200
Subject: [PATCH v3 2/2] arm64: dts: rockchip: add 96boards RK3399 Ficus
 board
In-Reply-To: <cceccdfefbcf9a5dcc5d683e7c7d4a2d16949344.camel@collabora.com>
References: <20180705150818.29931-1-ezequiel@collabora.com>
 <20180705234124.GA32051@rob-hp-laptop>
 <cceccdfefbcf9a5dcc5d683e7c7d4a2d16949344.camel@collabora.com>
Message-ID: <5173203.kQ7HMvCHTa@phil>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Freitag, 6. Juli 2018, 15:46:55 CEST schrieb Ezequiel Garcia:
> On Thu, 2018-07-05 at 17:41 -0600, Rob Herring wrote:
> > On Thu, Jul 05, 2018 at 12:08:18PM -0300, Ezequiel Garcia wrote:
> > > The RK3399 Ficus board is an Enterprise Edition board
> > > manufactured by Vamrs Ltd., based on the Rockchip RK3399 SoC.
> > > 
> > > The board exposes a bunch of nice peripherals, including
> > > SATA, HDMI, MIPI CSI, Ethernet, WiFi, and PCIe.
> > > 
> > > Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>
> > > 
> [snip]
> > > +
> > > +&i2c0 {
> > > +	clock-frequency = <400000>;
> > > +	i2c-scl-rising-time-ns = <168>;
> > > +	i2c-scl-falling-time-ns = <4>;
> > > +	status = "okay";
> > > +
> > > +	vdd_cpu_b: syr827 at 40 {
> > 
> > regulator at 40
> > 
> 
> OK.
> 
> > > +		compatible = "silergy,syr827";
> > > +		reg = <0x40>;
> > > +		fcs,suspend-voltage-selector = <1>;
> > 
> > Strange to have a different vendor for this property...
> > 
> 
> It's because this driver has also a Fairchild compatible
> "fcs,fan53555".

The Silergy regulators seem to be some sort of clone of
the Fairchild fan53555.
