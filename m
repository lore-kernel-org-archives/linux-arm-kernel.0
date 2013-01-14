From: balbi@ti.com (Felipe Balbi)
Date: Mon, 14 Jan 2013 19:40:54 +0200
Subject: [PATCH v3 1/3] usb: fsl-mxc-udc: replace cpu_is_xxx() with
 platform_device_id
In-Reply-To: <20130114125632.GA30157@nchen-desktop>
References: <20130114101642.GB10874@arwen.pp.htv.fi>
 <50F3DB8D.6050104@pengutronix.de>
 <20130114102444.GD10874@arwen.pp.htv.fi>
 <50F3DF1D.3040706@pengutronix.de>
 <20130114103952.GF10874@arwen.pp.htv.fi>
 <50F3E301.7040509@pengutronix.de>
 <20130114105357.GH10874@arwen.pp.htv.fi>
 <50F3E5E8.2000905@pengutronix.de>
 <20130114110600.GI10874@arwen.pp.htv.fi>
 <20130114125632.GA30157@nchen-desktop>
Message-ID: <20130114174054.GB12611@arwen.pp.htv.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 14, 2013 at 08:56:33PM +0800, Peter Chen wrote:

<snip>

> > > Usually there isn't any Changelog between IP cores used in the different
> > > fsl processors (at least available outside of fsl), that makes it quite
> > > difficult to say if something found on one imx is really the same as on
> > > the other one. And they (usually) don't provide any versioning
> > > information in a register or the documentation.
> > > 
> > > just my 2?
> > 
> > $SUBJECT is trying to differentiate a single feature (or maybe two) to
> > replace cpu_is_xxx(), then expose that on driver_data without creating
> > one enum value for each release from fsl.
> 
> Felipe, every one or two SoCs may have their special operations for
> integrate PHY interface, clk operation, or workaround for IC
> limitation.

the particular PHY and clk used should be hidden by phy layer and clk
API respectively. Workarounds, fair enough, we need to handle them; but
ideally those should be based on runtime revision detection, not some
hackery using driver_data.

> Maybe, it will add more future or SoCs (maybe not for this driver) in
> the future, using enum is easier than string comparison for expanding
> something.

a) I never told you to *not* use enum. I said that creating DEVICE_A,
DEVICE_B, DEVICE_C, DEVICE_D and DEVICE_E values when DEVICE_B,
DEVICE_C and DEVICE_E behave exactly the same is unnecessary.

b) you can't be expecting to add future SoCs support to fsl udc, I have
already said and will repeat for the last time: move to chipidea ASAP.

New SoCs cannot be added to fsl udc, you *must* use chipidea for
anything new and move the legacy to chipidea eventually. I will wait for
a full year for you to do that, but after that I will have to start
deleting drivers for the sake of avoid duplication of effort.

cheers

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130114/953ab9d5/attachment-0001.sig>
