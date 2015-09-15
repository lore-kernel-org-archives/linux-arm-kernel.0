From: tony@atomide.com (Tony Lindgren)
Date: Tue, 15 Sep 2015 08:40:58 -0700
Subject: [PATCH 6/6] ARM: dts: set up trigger type for edt-ft5x06
 interrupts
In-Reply-To: <20150914212426.GA9968@saruman.tx.rr.com>
References: <5044530af510d6686e78f8dfa912d89ef824f899.1442079408.git.dmitry.torokhov@gmail.com>
 <2adcbfd1d5b237598d37edcbeec4a8dbd443f36f.1442079408.git.dmitry.torokhov@gmail.com>
 <20150914212426.GA9968@saruman.tx.rr.com>
Message-ID: <20150915154058.GA4215@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Felipe Balbi <balbi@ti.com> [150914 14:28]:
> On Sat, Sep 12, 2015 at 10:45:51AM -0700, Dmitry Torokhov wrote:
> > Now that the driver respects IRQ trigger settings from device tree, let's
> > fix them up in individual DTSes (note that the driver is still compatible
> > with older DTSes).
> > 
> > Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> > ---
> >  arch/arm/boot/dts/am437x-sk-evm.dts   | 2 +-
> >  arch/arm/boot/dts/imx28-tx28.dts      | 3 ++-
> >  arch/arm/boot/dts/imx53-tx53-x03x.dts | 3 ++-
> >  arch/arm/boot/dts/imx6qdl-tx6.dtsi    | 3 ++-
> >  4 files changed, 7 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/arm/boot/dts/am437x-sk-evm.dts b/arch/arm/boot/dts/am437x-sk-evm.dts
> > index c17097d..d83fdcd 100644
> > --- a/arch/arm/boot/dts/am437x-sk-evm.dts
> > +++ b/arch/arm/boot/dts/am437x-sk-evm.dts
> > @@ -471,7 +471,7 @@
> >  
> >  		reg = <0x38>;
> >  		interrupt-parent = <&gpio0>;
> > -		interrupts = <31 0>;
> > +		interrupts = <31 IRQ_TYPE_EDGE_FALLING>;
> 
> for AM437x SK:
> 
> Acked-by: Felipe Balbi <balbi@ti.com>
> 
> Seems like there are no changes considering driver was always using
> IRQF_TRIGGER_FALLING.

Should not cause merge conflicts AFAIK:

Acked-by: Tony Lindgren <tony@atomide.com>
