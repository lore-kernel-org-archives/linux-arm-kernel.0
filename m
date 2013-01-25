From: balbi@ti.com (Felipe Balbi)
Date: Fri, 25 Jan 2013 18:23:46 +0200
Subject: [PATCH v4 1/4] drivers: usb: phy: add a new driver for usb part
 of control module
In-Reply-To: <20130125161401.GD16795@e106331-lin.cambridge.arm.com>
References: <1359109440-2195-1-git-send-email-kishon@ti.com>
 <1359109440-2195-2-git-send-email-kishon@ti.com>
 <20130125110141.GK3075@e106331-lin.cambridge.arm.com>
 <20130125111120.GP15886@arwen.pp.htv.fi>
 <20130125122943.GB16795@e106331-lin.cambridge.arm.com>
 <20130125145928.GC28379@arwen.pp.htv.fi>
 <20130125161401.GD16795@e106331-lin.cambridge.arm.com>
Message-ID: <20130125162346.GM28379@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Jan 25, 2013 at 04:14:02PM +0000, Mark Rutland wrote:
> On Fri, Jan 25, 2013 at 02:59:28PM +0000, Felipe Balbi wrote:
> > Hi,
> > 
> > On Fri, Jan 25, 2013 at 12:29:43PM +0000, Mark Rutland wrote:
> > > > > > +   depending upon omap4 or omap5.
> > > > > > + - reg-names: The names of the register addresses corresponding to the registers
> > > > > > +   filled in "reg".
> > > > > > + - ti,type: This is used to differentiate whether the control module has
> > > > > > +   usb mailbox or usb3 phy power. omap4 has usb mailbox in control module to
> > > > > > +   notify events to the musb core and omap5 has usb3 phy power register to
> > > > > > +   power on usb3 phy. Should be "1" if it has mailbox and "2" if it has usb3
> > > > > > +   phy power.
> > > > > 
> > > > > Why not make this a string property, perhaps values "mailbox" or "register"?
> > > > 
> > > > NAK.
> > > 
> > > Can I ask what your objection to using a string property is?
> > > 
> > > As far as I can see, "ti,type" is only used by this driver, so there's no
> > > common convention to stick to. Using a string makes the binding easier for
> > > humans to read, and thus harder to mess up in a dts, and it decouples the
> > > binding from kernel-side constants.
> > 
> > IIRC there is some work going on to add #define-like support for DT,
> > which would allow us to match against integers while still having
> > meaningful symbolic representations.
> 
> I was under the impression that the motivation for using the preprocessor on
> the DT was to allow symbolic names for device/soc-specific values like
> addresses, rather than what amounts to ABI values for the binding.
> 
> I don't see the point in building a binding that depends on future
> functionality to be legible, especially as we can make it more readable,
> robust, and just as extensible today, with a simple change to the proposed
> binding.
> 
> Even ignoring the above, the driver isn't doing appropriate sanity checking.
> If you use a string property, this sanity check is implicit in the parsing --
> you've either matched a value you can handle or you haven't.

Even IRQs use numbers (not talking about the IRQ number, but the IRQ
flags), why would we depend on string comparisson ? It doesn't make
sense.

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130125/1d9f17bb/attachment-0001.sig>
