From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Nov 2013 12:22:44 +0000
Subject: [PATCHv5] dmaengine: Add support for BCM2835
In-Reply-To: <20131116114134.GU16735@n2100.arm.linux.org.uk>
References: <52864BBC.7000506@koalo.de> <1384537403.14845.131.camel@smile>
 <20131115175155.GQ16735@n2100.arm.linux.org.uk>
 <CAHp75Vf3CJNgSiSjoZ6dYjRRHWN4bTpMxRTLG37+wwtEsQbq4g@mail.gmail.com>
 <20131116112754.GT15393@sirena.org.uk>
 <20131116114134.GU16735@n2100.arm.linux.org.uk>
Message-ID: <20131116122244.GV15393@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 16, 2013 at 11:41:34AM +0000, Russell King - ARM Linux wrote:
> On Sat, Nov 16, 2013 at 11:27:54AM +0000, Mark Brown wrote:

> > We should in general be moving in that direction however it does need a
> > bit of care to make sure that there aren't any dependencies which do
> > things like discard error codes, fail to check errors or treat errors as
> > hard failures.

> I don't agree: on platforms which have done this, it's very difficult to
> tell from reading the kernel message log whether things came up correctly
> because there's soo much spew from deferred probing it's virtually
> impossible to tell whether component X initialised or whether that error
> about resource Y missing was ever resolved.

I do agree that deferred programming is far too chatty - there's a
usability issue there.  This bites me a lot on some of my systems too, I
tend to read my logs with grep a lot which isn't awesome.

> If we want kernel boot logs to be useful, we really need to shut up *all*
> the drivers and subsystems whinging about being deferred probing, and only
> have the driver model core reporting this status - maybe only allow
> output about why at debug level or similar.

Yes, some sort of standardisation of how this stuff gets reported would
give us much better control of these things.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131116/77ea498d/attachment.sig>
