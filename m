From: maitysanchayan@gmail.com (maitysanchayan at gmail.com)
Date: Mon, 10 Aug 2015 14:47:25 +0530
Subject: [PATCH v7 4/4] nvmem: Add DT binding documentation for Vybrid
 OCOTP driver
In-Reply-To: <55C86C49.6080708@linaro.org>
References: <cover.1438874125.git.maitysanchayan@gmail.com>
 <3713643bb44c39c2126edca2916e1c1aa43eabf8.1438874125.git.maitysanchayan@gmail.com>
 <55C86C49.6080708@linaro.org>
Message-ID: <20150810091725.GB2273@Sanchayan-Arch.toradex.int>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 15-08-10 10:18:01, Srinivas Kandagatla wrote:
> 
> 
> On 06/08/15 16:27, Sanchayan Maity wrote:
> > Add the devicetree bindings for the Freescale Vybrid On-Chip
> > OTP driver.
> >
> > Signed-off-by: Sanchayan Maity <maitysanchayan@gmail.com>
> > ---
> >   .../devicetree/bindings/nvmem/vf610-ocotp.txt        | 20 ++++++++++++++++++++
> >   1 file changed, 20 insertions(+)
> >   create mode 100644 Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> >
> > diff --git a/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> > new file mode 100644
> > index 0000000..5556810
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/nvmem/vf610-ocotp.txt
> > @@ -0,0 +1,20 @@
> > +On-Chip OTP Memory for Freescale Vybrid
> > +
> > +Required Properties:
> > +  compatible:
> > +  - "fsl,vf610-ocotp" for VF5xx/VF6xx
> > +  #address-cells : Should be 1
> > +  #size-cells : Should be 1
> > +  reg : Address and length of OTP controller registers
> 
> Is there a reason to not add clocks property in to the bindings?

An error on my part. Will fix with the next revision.

- Sanchayan.

> 
> > +
> > +Example for Vybrid VF5xx/VF6xx:
> > +
> > +	ocotp: ocotp at 400a5000 {
> > +		compatible = "fsl,vf610-ocotp";
> > +		#address-cells = <1>;
> > +		#size-cells = <1>;
> > +		reg = <0x400a5000 0xD00>;
> > +		clocks = <&clks VF610_CLK_OCOTP>;
> > +		clock-names = "ocotp";
> > +	};
> > +
> >
