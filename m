From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 17 Feb 2012 08:29:09 -0800
Subject: [PATCH] ARM: 3ds_debugboard: Let ethernet be functional again
In-Reply-To: <20120217074007.GM3852@pengutronix.de>
References: <1328646473-11828-1-git-send-email-festevam@gmail.com>
 <20120213082741.GN3852@pengutronix.de>
 <20120213144820.GA3494@opensource.wolfsonmicro.com>
 <20120214105823.GS3852@pengutronix.de>
 <20120214172902.GB3916@opensource.wolfsonmicro.com>
 <20120216073236.GE3852@pengutronix.de>
 <20120216075825.GA11631@opensource.wolfsonmicro.com>
 <20120216091352.GK3852@pengutronix.de>
 <20120216162703.GB3383@opensource.wolfsonmicro.com>
 <20120217074007.GM3852@pengutronix.de>
Message-ID: <20120217162909.GA10146@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 08:40:07AM +0100, Sascha Hauer wrote:
> On Thu, Feb 16, 2012 at 08:27:04AM -0800, Mark Brown wrote:

> > Oh, in that case it seems really odd that it's returning a pointer to
> > the device rather than just returning success or failure.

> It has to as it gives you a pointer which you can use to unregister the
> device later. Also it's in line with the platform helpers like
> platform_device_register_resndata, platform_device_register_simple and
> others.

Hrm, right.  Again I'd expect all users to be in board code so not ever
unregistering anything.

> > In all these cases there is actually a physical supply of some kind; if
> > there isn't one then you'd expect the driver would have explicit code to
> > handle that in some way.

> Yes, there is one. But I think it will only be described in the device
> tree if it's software controllable.

I don't see why that needs to be the case.

> > without making an effort to go round all the uers and at least notify
> > the existing users of the device that they need updates.  There's a
> > limited amount we can do in the core

> Are you then willing to merge my patch to make it easier to not break
> boards? I would remove the voltage parameter and fix a remaining
> Kconfig/ifdef issue then.

Well, if you send a patch that looks sensible and is signed off and
whatnot yes.  I've no problem with a helper function.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120217/e681d441/attachment.sig>
