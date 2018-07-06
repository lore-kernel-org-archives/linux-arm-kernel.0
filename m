From: miquel.raynal@bootlin.com (Miquel Raynal)
Date: Fri, 6 Jul 2018 09:49:04 +0200
Subject: [PATCH v2 18/23] dt-bindings: thermal: armada: add reference to
 new bindings
In-Reply-To: <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
References: <20180625151239.20976-1-miquel.raynal@bootlin.com>
 <20180625151239.20976-19-miquel.raynal@bootlin.com>
 <20180703213011.GA13190@rob-hp-laptop>
 <20180705120528.4b923e16@xps13>
 <CAL_JsqL9h4RExZtm5cER-5kNvMpDzH-4MwcmY7VOLXB9-uEYYA@mail.gmail.com>
Message-ID: <20180706094904.22275b10@xps13>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

[...]

> > > > for AP806 and CP110 compatibles. Add a reference to these files from the
> > > > original documentation.
> > > >
> > > > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
> > > > ---
> > > >  Documentation/devicetree/bindings/thermal/armada-thermal.txt | 5 +++++
> > > >  1 file changed, 5 insertions(+)
> > > >
> > > > diff --git a/Documentation/devicetree/bindings/thermal/armada-thermal.txt b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > index e0d013a2e66d..f3b441100890 100644
> > > > --- a/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > +++ b/Documentation/devicetree/bindings/thermal/armada-thermal.txt
> > > > @@ -10,6 +10,11 @@ Required properties:
> > > >      * marvell,armada-ap806-thermal
> > > >      * marvell,armada-cp110-thermal  
> > >
> > > Really you should not be using the same compatible for both. Now you
> > > have 2 drivers matching to same compatibles.
> > >
> > > Can't you make this a child of the syscon without breaking the binding?  
> >
> > We are talking about only 1 driver here, so I'm not sure how I should
> > understand your last sentence. Do you want me to add a second
> > compatible (for the same piece of hardware) for thermal node declared
> > as a child of the syscon?  
> 
> I don't know what I'm suggesting. Your changes look like they break
> compatibility to me.

There is code in the driver to handle the legacy non-syscon-ish thermal
node ("armada_thermal_probe_legacy()"). An old DT with a new kernel
would work fine.

> What happens if you use this new binding without any kernel change?

I suppose you mean "during the merge window"? In this case the driver
of the thermal IP will not probe (and spawn an error in the dmesg) with
ap806/cp110 IPs. As the support is pretty new for them, this is maybe
not a huge issue. Also, before the DT changes adding thermal zones,
just retrieving the temperature might be pretty useless. However, it
is always possible to merge the driver changes in 4.19 and the DT
changes in 4.20.


Thanks,
Miqu?l
