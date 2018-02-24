From: jic23@kernel.org (Jonathan Cameron)
Date: Sat, 24 Feb 2018 13:28:14 +0000
Subject: [PATCH] dt-bindings: iio: adc: sd-modulator: fix io-channel-cells
In-Reply-To: <c221e43d-c7fb-c33b-6fd1-bbf8aca6fa49@st.com>
References: <1519384041-23782-1-git-send-email-fabrice.gasnier@st.com>
 <c221e43d-c7fb-c33b-6fd1-bbf8aca6fa49@st.com>
Message-ID: <20180224132814.392603c3@archlinux>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 23 Feb 2018 14:46:19 +0100
Arnaud Pouliquen <arnaud.pouliquen@st.com> wrote:

> Hello,
> 
> Acked-by: Arnaud Pouliquen <arnaud.pouliquen@st.com>
Applied to the fixes-togreg branch of iio.git.

Thanks,

Jonathan
> 
> Regards,
> Arnaud
> 
> On 02/23/2018 12:07 PM, Fabrice Gasnier wrote:
> > io-channel-cells should be <0> since sigma delta modulator exports only
> > one channel, as described in ../iio/iio-bindings.txt "IIO providers"
> > section. Only the phandle is necessary for IIO consumers in this case.
> > 
> > Fixes: af11143757b7 ("IIO: Add DT bindings for sigma delta adc modulator")
> > 
> > Signed-off-by: Fabrice Gasnier <fabrice.gasnier@st.com>
> > ---
> >  Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> > index e9ebb8a..ba24ca7 100644
> > --- a/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> > +++ b/Documentation/devicetree/bindings/iio/adc/sigma-delta-modulator.txt
> > @@ -3,11 +3,11 @@ Device-Tree bindings for sigma delta modulator
> >  Required properties:
> >  - compatible: should be "ads1201", "sd-modulator". "sd-modulator" can be use
> >  	as a generic SD modulator if modulator not specified in compatible list.
> > -- #io-channel-cells = <1>: See the IIO bindings section "IIO consumers".
> > +- #io-channel-cells = <0>: See the IIO bindings section "IIO consumers".
> >  
> >  Example node:
> >  
> >  	ads1202: adc at 0 {
> >  		compatible = "sd-modulator";
> > -		#io-channel-cells = <1>;
> > +		#io-channel-cells = <0>;
> >  	};
> >   
