From: soren.brinkmann@xilinx.com (=?utf-8?B?U8O2cmVu?= Brinkmann)
Date: Thu, 3 Apr 2014 13:15:52 -0700
Subject: [PATCH v4 1/3] i2c: cadence: Document device tree bindings
In-Reply-To: <CAL_Jsq+vOHzca_wT9ADHRxhR9dT8FYGP-iTvd5=zKrRVBZz-cw@mail.gmail.com>
References: <1396547967-19260-1-git-send-email-soren.brinkmann@xilinx.com>
 <CAL_Jsq+vOHzca_wT9ADHRxhR9dT8FYGP-iTvd5=zKrRVBZz-cw@mail.gmail.com>
Message-ID: <19eac9d5-7c83-4fca-b3e8-fc225b6559bd@CH1EHSMHS033.ehs.local>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-04-03 at 02:51PM -0500, Rob Herring wrote:
> On Thu, Apr 3, 2014 at 12:59 PM, Soren Brinkmann
> <soren.brinkmann@xilinx.com> wrote:
> > Add device tree binding documentation for the Cadence I2C controller.
> >
> > Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>
> > ---
> >
> > Changes in v4:
> >  - moved adding DT docs into this dedicated patch
> >
> > Changes in v3: None
> > Changes in v2: None
> >
> > ---
> >  .../devicetree/bindings/i2c/i2c-cadence.txt         | 21 +++++++++++++++++++++
> >  1 file changed, 21 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> >
> > diff --git a/Documentation/devicetree/bindings/i2c/i2c-cadence.txt b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> > new file mode 100644
> > index 000000000000..685adf513111
> > --- /dev/null
> > +++ b/Documentation/devicetree/bindings/i2c/i2c-cadence.txt
> > @@ -0,0 +1,21 @@
> > +Binding for the Cadence I2C controller
> > +
> > +Required properties:
> > +  compatible: Compatibility string. Must be 'cdns,i2c-r1p10'.
> > +  clocks: From common clock bindings. Phandle to input clock.
> > +
> > +Optional properties:
> > +  clock-frequency: Desired operating frequency, in Hz, of the bus (actual may
> > +                  be lower). Defaults to 400000 if not specified.
> 
> Since not all devices support 400kHz, I would prefer that the default
> be 100kHz. Also, it would be good if what speed the default is
> consistent across i2c drivers.

Fine with me. I'll change this.

	Thanks,
	S?ren
