From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Tue, 13 Feb 2018 08:58:28 +0100
Subject: [PATCH v5 0/6] IR support for A83T
In-Reply-To: <a1ce4422-33d7-1214-6527-0d299e97fe8b@gmail.com>
References: <20180130174656.10657-1-embed3d@gmail.com>
 <a1ce4422-33d7-1214-6527-0d299e97fe8b@gmail.com>
Message-ID: <20180213075828.zkm2p67dsr7f6bde@flea.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Philipp,

On Mon, Feb 12, 2018 at 12:00:02PM +0100, Philipp Rossak wrote:
> On 30.01.2018 18:46, Philipp Rossak wrote:
> > This patch series adds support for the sunxi A83T ir module and enhances
> > the sunxi-ir driver. Right now the base clock frequency for the ir driver
> > is a hard coded define and is set to 8 MHz.
> > This works for the most common ir receivers. On the Sinovoip Bananapi M3
> > the ir receiver needs, a 3 MHz base clock frequency to work without
> > problems with this driver.
> > 
> > This patch series adds support for an optinal property that makes it able
> > to override the default base clock frequency and enables the ir interface
> > on the a83t and the Bananapi M3.
> > 
> > changes since v4:
> > * rename cir pin from cir_pins to r_cir_pin
> > * drop unit-adress from r_cir_pin
> > * add a83t compatible to the cir node
> > * move muxing options to dtsi
> > * rename cir label and reorder it in the bananpim3.dts file
> > 
> > changes since v3:
> > * collecting all acks & reviewd by
> > * fixed typos
> > 
> > changes since v2:
> > * reorder cir pin (alphabetical)
> > * fix typo in documentation
> > 
> > changes since v1:
> > * fix typos, reword Documentation
> > * initialize 'b_clk_freq' to 'SUNXI_IR_BASE_CLK' & remove if statement
> > * change dev_info() to dev_dbg()
> > * change naming to cir* in dts/dtsi
> > * Added acked Ackedi-by to related patch
> > * use whole memory block instead of registers needed + fix for h3/h5
> > 
> > changes since rfc:
> > * The property is now optinal. If the property is not available in
> >    the dtb the driver uses the default base clock frequency.
> > * the driver prints out the the selected base clock frequency.
> > * changed devicetree property from base-clk-frequency to clock-frequency
> > 
> > Regards,
> > Philipp
> > 
> > Philipp Rossak (6):
> >    media: rc: update sunxi-ir driver to get base clock frequency from
> >      devicetree
> >    media: dt: bindings: Update binding documentation for sunxi IR
> >      controller
> >    arm: dts: sun8i: a83t: Add the cir pin for the A83T
> >    arm: dts: sun8i: a83t: Add support for the cir interface
> >    arm: dts: sun8i: a83t: bananapi-m3: Enable IR controller
> >    arm: dts: sun8i: h3-h5: ir register size should be the whole memory
> >      block
> > 
> >   Documentation/devicetree/bindings/media/sunxi-ir.txt |  3 +++
> >   arch/arm/boot/dts/sun8i-a83t-bananapi-m3.dts         |  5 +++++
> >   arch/arm/boot/dts/sun8i-a83t.dtsi                    | 18 ++++++++++++++++++
> >   arch/arm/boot/dts/sunxi-h3-h5.dtsi                   |  2 +-
> >   drivers/media/rc/sunxi-cir.c                         | 19 +++++++++++--------
> >   5 files changed, 38 insertions(+), 9 deletions(-)
> > 
> 
> RC1 is now out, thus I would like to ask you to have a look at this patch
> series again. Some patches still miss an acked-by. It would be nice if we
> could schedule this for v4.17.

Just resend it, this will send pretty much the same signal :)

Maxime

-- 
Maxime Ripard, Bootlin (formerly Free Electrons)
Embedded Linux and Kernel engineering
http://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180213/ed70a08d/attachment-0001.sig>
