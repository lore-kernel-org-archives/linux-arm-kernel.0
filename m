From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Wed, 7 Nov 2018 10:44:24 +0100
Subject: [PATCH v3 00/28] Allwinner H6 DE3 and HDMI support
In-Reply-To: <3766119.46PGZN2PQn@jernej-laptop>
References: <20181104182705.18047-1-jernej.skrabec@siol.net>
 <20181105094341.qedt7jvnxooiojki@flea>
 <3766119.46PGZN2PQn@jernej-laptop>
Message-ID: <20181107094424.3nbmyq3cnuzevxoa@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2018 at 06:20:39PM +0100, Jernej ?krabec wrote:
> Dne ponedeljek, 05. november 2018 ob 10:43:41 CET je Maxime Ripard napisal(a):
> > On Sun, Nov 04, 2018 at 07:26:37PM +0100, Jernej Skrabec wrote:
> > > This series adds support for Display Engine 3.0 and HDMI 2.0a, which
> > > can be found on H6 SoC.
> > > 
> > > Display Engine 3.0 in comparison to 2.0 mostly adds features needed for
> > > displaying and processing 10-bit and AFBC formats, which are not yet
> > > supported by this series.
> > > 
> > > H6 is also the first SoC which supports IOMMU, but support for it is
> > > not yet added.
> > > 
> > > This series is based on linux-next at next-20181102.
> > > 
> > > I suggest all patches go through allwinner tree, except DRM patches,
> > > which should go through drm-misc tree.
> > 
> > Applied all patches up to the 26. The two last one however should not
> > use the clk bindings define you added in the first clk patches, since
> > clk and dt patches are going through different tree.
> 
> I went over clock defines again, but I don't think I use anything new. New 
> defines are:
> 
> #define CLK_BUS_ROT            9
> #define CLK_ROT                        10
> #define RST_ROT                3
> 
> but none of them are actually used in DT.
> 
> Did I miss anything?

No, I did. Sorry for that. Patches 27 and 28 are applied now.

I've fixed a few things in the patch 27, to fix the order of the de
node, and change the de3 node name, since it's supposed to be a
generic class name. I renamed it to display-engine.

Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181107/204cf5ad/attachment.sig>
