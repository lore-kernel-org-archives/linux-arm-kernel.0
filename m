From: yong.wu@mediatek.com (Yong Wu)
Date: Mon, 9 Mar 2015 20:32:26 +0800
Subject: [PATCH 3/5] dt-bindings: mediatek: Add smi dts binding
In-Reply-To: <54F9BE55.90601@cogentembedded.com>
References: <1425638900-24989-1-git-send-email-yong.wu@mediatek.com>
 <1425638900-24989-4-git-send-email-yong.wu@mediatek.com>
 <54F9BE55.90601@cogentembedded.com>
Message-ID: <1425904346.13300.37.camel@mhfsdcap03>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Sergei,
	Thanks very much for suggestion.
        I will fix them in the next version.

On Fri, 2015-03-06 at 17:48 +0300, Sergei Shtylyov wrote:
> Hello.
> 
> On 3/6/2015 1:48 PM, yong.wu at mediatek.com wrote:
> 
> > From: Yong Wu <yong.wu@mediatek.com>
> 
> > This patch add smi binding document.
> 
> > Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> > ---
> >   .../devicetree/bindings/soc/mediatek/mediatek,smi.txt   | 17 +++++++++++++++++
> >   1 file changed, 17 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> 
> > diff --git a/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > new file mode 100644
> > index 0000000..0fc9d1a
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/soc/mediatek/mediatek,smi.txt
> > @@ -0,0 +1,17 @@
> > +SMI hardware block diagram please help check <bindings/iommu/mediatek,iommu.txt>
> > +
> > +Required properties:
> > +- compatible : must be "mediatek,mediatek,mt8173-smi-larb"
> 
>     One "mediatek," is enough. :-)
> 
> > +- reg : the register of each local arbiter
> > +- clocks : the clocks of each local arbiter
> > +- clock-name: larb_sub*(3 clockes at most)
> 
>     clock-names.
> 
> > +
> > +Example:
> > +	larb1:larb at 16010000 {
> > +	        compatible = "mediatek,mt8173-smi-larb";
> > +		reg = <0 0x16010000 0 0x1000>;
> > +		clocks = <&mmsys MM_SMI_COMMON>,
> > +		        <&vdecsys VDEC_CKEN>,
> 
>     Please align with the < above.
> 
> > +                        <&vdecsys VDEC_LARB_CKEN>;
> 
>     Use tabs instead of spaces, please.
> 
> > +		clock-names = "larb_sub0", "larb_sub1", "larb_sub2";
> > +	};
> 
> WBR, Sergei
> 
