From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 22 Oct 2015 10:47:35 +0200
Subject: [PATCH 5/6] ARM: dts: sunxi: Add Allwinner H3 DTSI
In-Reply-To: <20151022102959.09f0a1f4@OPI2>
References: <1445444428-4652-1-git-send-email-jenskuske@gmail.com>
 <1445444428-4652-2-git-send-email-jenskuske@gmail.com>
 <20151022080508.GN10947@lukather> <20151022102959.09f0a1f4@OPI2>
Message-ID: <20151022084735.GR10947@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 22, 2015 at 10:29:59AM +0200, Jean-Francois Moine wrote:
> On Thu, 22 Oct 2015 10:05:08 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > > +		uart0: serial at 01c28000 {
> > > +			compatible = "snps,dw-apb-uart";
> > > +			reg = <0x01c28000 0x400>;
> > > +			interrupts = <GIC_SPI 0 IRQ_TYPE_LEVEL_HIGH>;
> > > +			reg-shift = <2>;
> > > +			reg-io-width = <4>;
> > > +			clocks = <&bus_gates 112>;
> > > +			resets = <&bus_rst 208>;  
> > 
> > It's a bit weird that the clocks and reset indices don't match,
> > usually they do.
> > 
> > What's even weirder is that there's a 96 offset between the two (4 *
> > 32), is this expected?
> 
> Yes, this is conform to the H3 documentation.

Not really. The uart0 reset is the bit 16, in the reset register 4.

4 * 32 + 16 = 44.

Not 112, but still not 208 either.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151022/c2923062/attachment.sig>
