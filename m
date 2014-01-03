From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 3 Jan 2014 18:15:59 +0100
Subject: [PATCH 1/4] input: Add new sun4i-lradc-keys drivers
In-Reply-To: <20140102203831.GA3239@core.coreip.homeip.net>
References: <1388604610-20380-1-git-send-email-hdegoede@redhat.com>
 <20140101205603.GA1141@core.coreip.homeip.net>
 <52C5336B.9010903@redhat.com> <1700375.GaI3zFl6RI@phil>
 <52C56D79.1060506@redhat.com> <20140102202022.GK3144@lukather>
 <20140102203831.GA3239@core.coreip.homeip.net>
Message-ID: <20140103171559.GM3144@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 02, 2014 at 12:38:31PM -0800, Dmitry Torokhov wrote:
> On Thu, Jan 02, 2014 at 09:20:22PM +0100, Maxime Ripard wrote:
> > On Thu, Jan 02, 2014 at 02:45:29PM +0100, Hans de Goede wrote:
> > > >Also, instead of inventing yet another vendor-specific property, why not re-use
> > > >a button binding similar to gpio-keys like:
> > > >
> > > >        lradc: lradc at 01c22800 {
> > > >                compatible = "allwinner,sun4i-lradc-keys";
> > > >                reg = <0x01c22800 0x100>;
> > > >                interrupts = <31>;
> > > >                allwinner,chan0-step = <200>;
> > > >
> > > >		#address-cells = <1>;
> > > >		#size-cells = <0>;
> > > >
> > > >		button at 0 {
> > > >			reg = <0>; /* your channel index from above */
> > > >			linux,code = <115>; /* already used as dt-property */
> > > >		};
> > > >
> > > >		button at 1 {
> > > >			reg = <1>;
> > > >			linux,code = <114>;
> > > >		};
> > > 
> > > Ugh no. Having a vendor specific property which is KISS certainly
> > > beats this, both wrt ease of writing dts files as well as wrt the
> > > dts parsing code in the driver.
> > 
> > I'd agree with Heiko here. This is pretty much the same construct
> > that's already in use in other input drivers, like gpio-keys.
> > 
> > This is also something that can really easily be made generic, since
> > this is something that is rather common.
> 
> Except that button definition from gpio-keys does not use 'reg' property
> but rather gpio. I'd rather we did not cram non-applicable attributes
> into that definition just to make it "reusable" like that.
> 
> I'd be OK with having similar (but not claiming to be the same) mappings
> though.

Yes, this is what I was meaning. Sorry if it was not clear enough.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140103/b1b5c3a0/attachment.sig>
