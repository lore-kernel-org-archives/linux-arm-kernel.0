From: broonie@kernel.org (Mark Brown)
Date: Thu, 25 Jul 2013 14:53:19 +0100
Subject: How to create IRQ mappings in a GPIO driver that doesn't control
 its IRQ domain ?
In-Reply-To: <CACRpkdY-mdLbMY16aMqR9Jwu8qs9q4KNyxOxnwhXiGrAAxpKjg@mail.gmail.com>
References: <1624911.6TtmtVmU1T@avalon>
 <CACRpkdazPX3EbVbLvXQZh0oRBpHoWPK+EkFO75v9zfAXSPCkHA@mail.gmail.com>
 <1408178.cxAUTUGJc5@avalon> <20130725131556.GD9858@sirena.org.uk>
 <CACRpkdY-mdLbMY16aMqR9Jwu8qs9q4KNyxOxnwhXiGrAAxpKjg@mail.gmail.com>
Message-ID: <20130725135319.GF9858@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 25, 2013 at 03:21:35PM +0200, Linus Walleij wrote:
> On Thu, Jul 25, 2013 at 3:15 PM, Mark Brown <broonie@kernel.org> wrote:

> > Are the interrupts in a contiguous block in the controller so you can
> > just pass around the controller and a base number?

> That works with platform data and in-kernel structures, but AFAICT
> device tree has no such "bulk" concept but expects you to list
> each and every line individually in cases like this.

It works fine with domains as well - the domains all have a hwirq number
which is local to the domain context and doesn't correspond to a Linux
interrupt number.  If you can say "the X interrupts in this domain
starting at Y correspond to these X GPIOs" then you should be able to
cope.  Hopefully.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130725/4d30ee7c/attachment.sig>
