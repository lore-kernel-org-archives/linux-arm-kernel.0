From: antoine.tenart@free-electrons.com (Antoine Tenart)
Date: Tue, 30 May 2017 08:51:47 +0200
Subject: [PATCH v2 12/12] ARM: sun5i: add a cryptographic engine node
In-Reply-To: <20170530064811.idsv66mvfyh2tyiw@flea.lan>
References: <20170529202738.2167-1-antoine.tenart@free-electrons.com>
 <20170529202738.2167-13-antoine.tenart@free-electrons.com>
 <20170530064811.idsv66mvfyh2tyiw@flea.lan>
Message-ID: <20170530065147.GB5802@kwain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Maxime,

On Tue, May 30, 2017 at 08:48:11AM +0200, Maxime Ripard wrote:
> On Mon, May 29, 2017 at 10:27:38PM +0200, Antoine Tenart wrote:
> > Add a node for the cryptographic engine that can be found on sun5i SoCs.
> > This cryptographic engine is compatible with the Allwinner cryptographic
> > accelerator driver.
> > 
> > Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> > ---
> >  arch/arm/boot/dts/sun5i.dtsi | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> > 
> > diff --git a/arch/arm/boot/dts/sun5i.dtsi b/arch/arm/boot/dts/sun5i.dtsi
> > index 5175f9cc9bed..9bfefa2c7224 100644
> > --- a/arch/arm/boot/dts/sun5i.dtsi
> > +++ b/arch/arm/boot/dts/sun5i.dtsi
> > @@ -355,6 +355,14 @@
> >  			status = "disabled";
> >  		};
> >  
> > +		crypto: crypto-engine at 01c15000 {
> > +			compatible = "allwinner,sun4i-a10-crypto";
> 
> you should add a SoC-specific compatible here, just so that if we ever
> need to fix something in there we don't have to update our DT.

Sure. I'll also make patches for the other sunXi crypto nodes as they do
no have SoC-specific compatibles either.

Thanks,
Antoine

-- 
Antoine T?nart, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170530/0ac167d0/attachment.sig>
