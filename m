From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 5 Apr 2017 10:13:10 +0200
Subject: [PATCH 2/3] arm64: allwinner: a64: add USB0 OHCI/EHCI related
 devicetree parts
In-Reply-To: <a4ca2175-b4df-42e4-1f85-20d34430d4dc@aosc.io>
References: <20170404184518.33610-1-icenowy@aosc.io>
 <20170404184518.33610-2-icenowy@aosc.io>
 <20170405071508.yaur35xuli4jgkfb@lukather>
 <7828ffa0-f570-9841-a9e6-fe175f8169ac@aosc.io>
 <20170405072631.ou4e5gafvagwpykq@lukather>
 <a4ca2175-b4df-42e4-1f85-20d34430d4dc@aosc.io>
Message-ID: <20170405081310.fxts5ut7srtnjiiy@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 05, 2017 at 03:33:09PM +0800, Icenowy Zheng wrote:
> > > P.S. to be compatible with older DTs, I think I should adjust
> > > the phy driver, make it enable dual-route function only when
> > > pmu0 is present.
> > 
> > That, or if we're quick enough, we can still add it to 4.11. There's a
> > bit of time left.
> 
> Thus the device tree binding patch and the DT part of this patchset
> should be all pushed to 4.11 .
> 
> The device tree binding patch is commit ee73fd7dfc86 ("dt: bindings:
> add pmu0 regs for USB PHYs on Allwinner H3/V3s/A64").

It should have always been there. If there is a register for the PHY
somewhere, it must be in the DT node. Period. There's not relation to
whether the driver actually uses it or not.

Please send a patch to add that range for 4.11.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170405/e23ba2cf/attachment-0001.sig>
