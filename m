From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 30 Oct 2012 14:54:21 +0000
Subject: [PATCHv2] Input: omap4-keypad: Add pinctrl support
In-Reply-To: <CACRpkdZysB2mxj5wZfE0N+iwTE-_AXbOV0bKRP5kSo=1hieKGg@mail.gmail.com>
References: <4099134.xWUIfbbahk@dtor-d630.eng.vmware.com>
 <20121024185818.GB772@arwen.pp.htv.fi>
 <20121025205901.GA3827@sirena.org.uk>
 <20121026062008.GA21734@arwen.pp.htv.fi>
 <20121026160316.GY18814@opensource.wolfsonmicro.com>
 <20121029194901.GA30152@arwen.pp.htv.fi>
 <20121030112410.GM4511@opensource.wolfsonmicro.com>
 <20121030114949.GC28722@arwen.pp.htv.fi>
 <20121030140714.GO4511@opensource.wolfsonmicro.com>
 <CACRpkdZysB2mxj5wZfE0N+iwTE-_AXbOV0bKRP5kSo=1hieKGg@mail.gmail.com>
Message-ID: <20121030145420.GQ4511@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 03:16:02PM +0100, Linus Walleij wrote:
> On Tue, Oct 30, 2012 at 3:07 PM, Mark Brown

> > Essentially all the patches I'm seeing adding pinctrl are totally
> > mindless, most of them are just doing the initial setup on boot and not
> > doing any active management at runtime at all.

> I concludes in some other mails that all Ux500 drivers
> will need to handle atleast two states (default and sleep)
> and some a third state (idle).

Right, that's the other common option and obviously it's just an
extension of the simple hogs which maps very nicely onto the existing PM
states for devices.

> And this is what we're doing in our patches.

> Arguably it can all be pushed to power domains, but that
> will as said mandate all affected systems to implement
> power domains, and effectively moving code from
> drivers/* to arch/arm/* in our case atleast.

As soon as they start adding clock support and so on, yes.  Obviously if
they don't want to use any of the features that are offloaded like this
then they could happily ignore it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121030/1a4adf30/attachment.sig>
