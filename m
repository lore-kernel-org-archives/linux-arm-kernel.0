From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Sun, 6 Sep 2015 15:58:13 +0530
Subject: [PATCH v9 4/4] nvmem: Add DT binding documentation for Vybrid
 OCOTP driver
In-Reply-To: <20150906081334.GK30746@tiger>
References: <cover.1439384645.git.maitysanchayan@gmail.com>
 <24fcfdc695907103e8f4602b7dc6b8fa38e85ec1.1439384645.git.maitysanchayan@gmail.com>
 <20150906081334.GK30746@tiger>
Message-ID: <20150906102813.GA13499@Sanchayan-Arch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15-09-06 16:13:35, Shawn Guo wrote:
> On Wed, Aug 12, 2015 at 06:49:21PM +0530, Sanchayan Maity wrote:
> > Add the devicetree bindings for the Freescale Vybrid On-Chip
> > OTP driver.
> > 
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > ---
> >  .../devicetree/bindings/nvmem/vf610-ocotp.txt       | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> > 
> > diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> > new file mode 100644
> > index 0000000..b29f65f
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> > @@ -0,0 +1,21 @@
> > +On-Chip OTP Memory for Freescale Vybrid
> > +
> > +Required Properties:
> > +  compatible:
> > +  - "fsl,vf610-ocotp" for VF5xx/VF6xx
> > +  #address-cells : Should be 1
> > +  #size-cells : Should be 1
> > +  reg : Address and length of OTP controller and fuse map registers
> > +  clocks : ipg clock we associate with the OCOTP peripheral
> > +  clock-names : Must contain "ocotp" as matching entry
> 
> I'm not sure "ocotp" is a good name for describing a clock from OCOTP
> internal point of view.  "ipg" might be better.  But I would suggest you
> drop clock-names property completely, if "ipg" is the only clock you
> need to describe here.  The clock-names is necessary only when there are
> multiple clocks to distinguish.
> 
> With clock-names dropped, the driver works by passing NULL as the second
> parameter to devm_clk_get() call.

Ok. Will drop the clock-names property retest and try sending it by tomorrow.

- Sanchayan.

> 
> Shawn
> 
> > +
> > +Example for Vybrid VF5xx/VF6xx:
> > +
> > +	ocotp: ocotp at 400a5000 {
> > +		compatible = "fsl,vf610-ocotp";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0x400a5000 0xCF0>;
> > +		clocks = <&clks VF610_CLK_OCOTP>;
> > +		clock-names = "ocotp";
> > +	};
> > -- 
> > 2.5.0
> > 
