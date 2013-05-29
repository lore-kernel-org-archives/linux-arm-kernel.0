From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Wed, 29 May 2013 10:49:33 -0400 (EDT)
Subject: [PATCH 1/8] drivers: bus: add ARM CCI support
In-Reply-To: <1369829485.3715.46.camel@linaro1.home>
References: <1369374311-21260-1-git-send-email-nicolas.pitre@linaro.org>
 <1369374311-21260-2-git-send-email-nicolas.pitre@linaro.org>
 <1369829485.3715.46.camel@linaro1.home>
Message-ID: <alpine.LFD.2.03.1305291049000.1918@syhkavp.arg>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 29 May 2013, Jon Medhurst (Tixy) wrote:

> On Fri, 2013-05-24 at 01:45 -0400, Nicolas Pitre wrote:
> [...]
> > diff --git a/Documentation/devicetree/bindings/arm/cci.txt b/Documentation/devicetree/bindings/arm/cci.txt
> [...]
> > +	cci at 2c090000 {
> > +		compatible = "arm,cci-400";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0x0 0x2c090000 0 0x1000>;
> > +		ranges = <0x0 0x0 0x2c090000 0x6000>;
> > +
> > +		cci_control0: slave-if at 1000 {
> > +			interface-type = "ace-lite";
> > +			reg = <0x1000 0x1000>;
> > +		};
> > +
> > +		cci_control1: slave-if at 4000 {
> > +			interface-type = "ace";
> > +			reg = <0x4000 0x1000>;
> > +		};
> > +
> > +		cci_control2: slave-if at 5000 {
> > +			interface-type = "ace";
> > +			reg = <0x5000 0x1000>;
> > +		};
> > +	};
> 
> The above examples of slave-if nodes are missing the required
> compatible = "arm,cci-400-ctrl-if";

Indeed.  I'll fix that.


Nicolas
