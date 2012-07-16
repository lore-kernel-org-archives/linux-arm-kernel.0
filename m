From: w.sang@pengutronix.de (Wolfram Sang)
Date: Mon, 16 Jul 2012 14:35:50 +0200
Subject: linux-next: manual merge of the arm-soc tree with the
 i2c-embedded tree
In-Reply-To: <CACRpkdY626iYATorphAvg7cQxD2ufysBvXdt3Z644zEuW0wS=w@mail.gmail.com>
References: <20120710164130.f38e4d1673f925ddb13914c9@canb.auug.org.au>
 <20120712131231.GH2194@pengutronix.de>
 <CACRpkdboeF_G=sTPeSyuZ6KGLCmGSKx_NS=6Rim6HkR2f9=AAQ@mail.gmail.com>
 <20120716101706.GB17435@pengutronix.de>
 <CACRpkdY626iYATorphAvg7cQxD2ufysBvXdt3Z644zEuW0wS=w@mail.gmail.com>
Message-ID: <20120716123550.GE17435@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 01:37:13PM +0200, Linus Walleij wrote:
> On Mon, Jul 16, 2012 at 12:17 PM, Wolfram Sang <w.sang@pengutronix.de> wrote:
> 
> >> And about the perpetual nature of device tree bindings it
> >> appears to me that the modus operandi right now is to not
> >> regard any of these as written in stone until they are removed
> >> from the kernel tree. We have plenty of drivers patching
> >> trees and drivers in one for the moment.
> >
> > I don't get this one. Yes, they are of perpetual nature, so how could we
> > remove them from the kernel tree?
> 
> What I meant was that at the point when arch/arm/boot/dts/*
> is (if ever) removed from the kernel tree and into its own git, so that
> the standardization of bindings is decoupled from the Linux kernel
> tree, from that point it is no longer possible to alter the bindings
> and the code in sync, so at that point the bindings need to be
> frozen and all subsequent work will need to gear down and
> work on bindings before deployment.

Uhm, I seem to have missed that bindings are deemed more "flexible" as
long as they are coupled to in-kernel dts files? Is that discussed
somewhere? I do wonder about it...

> 
> That said, this does not at all solve the problem of already-deployed
> device trees using old bindings...

... exactly because of this. I don't think it is possible to really drop
a binding. Only to mark them deprecated. Which can really be messy in
drivers.

> > What I am afraid of is: tentative solutions tend to stay, because the
> > need for a proper solution is reduced. Yet, finding proper generic
> > bindings might take some time which doesn't meet the high pressure
> > around DT at the moment.
> 
> I'm +1 on this. But I have learned that I have had to strike a
> compromise with people who want to forge ahead. They see things
> in the other way: perpetual committee discussions and no code
> nor device trees being deployed... :-)

I do know both sides. I easily agree that we have to find a balance
somewhere to meet both interests. Though, currently my impressions from
maintaining I2C are:

a) it is not balanced, but too far on the "let's deploy stuff" side
b) developers have a tendency to simply map platform_data to bindings
   and are surprised when told this is often not possible

which adds burden to the maintainers (who sometimes might not even be
familiar with devicetree because they are not focused on embedded). And
I worry about bindings of unmaintained subsystems.

So, I guess, what I am basically hoping for is less pace and a wider
acceptance that bindings can be really non-trivial.

Regards,

   Wolfram

-- 
Pengutronix e.K.                           | Wolfram Sang                |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 198 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120716/63823b9d/attachment.sig>
