From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 16 Feb 2017 09:32:45 +0200
Subject: [PATCH 03/10] media: dt-bindings: vpif: extend the example with
 an output port
In-Reply-To: <20170215220822.nsws6kzrd6ihvmqt@rob-hp-laptop>
References: <1486485683-11427-1-git-send-email-bgolaszewski@baylibre.com>
 <1486485683-11427-4-git-send-email-bgolaszewski@baylibre.com>
 <20170215220822.nsws6kzrd6ihvmqt@rob-hp-laptop>
Message-ID: <3062753.kLFTTf9n8o@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On Wednesday 15 Feb 2017 16:08:22 Rob Herring wrote:
> On Tue, Feb 07, 2017 at 05:41:16PM +0100, Bartosz Golaszewski wrote:
> > This makes the example more or less correspond with the da850-evm
> > hardware setup.
> > 
> > Signed-off-by: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> > ---
> > 
> >  .../devicetree/bindings/media/ti,da850-vpif.txt    | 35 +++++++++++++----
> >  1 file changed, 29 insertions(+), 6 deletions(-)
> 
> Spoke too soon...
> 
> > diff --git a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> > b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt index
> > 9c7510b..543f6f3 100644
> > --- a/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> > +++ b/Documentation/devicetree/bindings/media/ti,da850-vpif.txt
> > @@ -28,19 +28,27 @@ I2C-connected TVP5147 decoder:
> >  		reg = <0x217000 0x1000>;
> >  		interrupts = <92>;
> > 
> > -		port {
> > -			vpif_ch0: endpoint at 0 {
> > +		port at 0 {
> > +			vpif_input_ch0: endpoint at 0 {
> >  				reg = <0>;
> >  				bus-width = <8>;
> > -				remote-endpoint = <&composite>;
> > +				remote-endpoint = <&composite_in>;
> >  			};
> > 
> > -			vpif_ch1: endpoint at 1 {
> > +			vpif_input_ch1: endpoint at 1 {
> >  				reg = <1>;
> >  				bus-width = <8>;
> >  				data-shift = <8>;
> >  			};
> >  		};
> > +
> > +		port at 1 {
> 
> The binding doc says nothing about supporting a 2nd port.
> 
> > +			vpif_output_ch0: endpoint at 0 {
> > +				reg = <0>;
> 
> Don't need reg here.

And the node should then be named endpoint, not endpoint at 0.

> > +				bus-width = <8>;
> > +				remote-endpoint = <&composite_out>;
> > +			};
> > +		};
> >  	};

-- 
Regards,

Laurent Pinchart
