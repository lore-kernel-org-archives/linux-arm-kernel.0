From: broonie@kernel.org (Mark Brown)
Date: Sat, 16 Aug 2014 00:19:25 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <201408152149.44283.arnd@arndb.de>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <8599266.1aeEWcB8r7@wuerfel>
 <CAOesGMiOzRYmmYcBV=eFr8U-e_BJAUg9gpnT0DPwJuyxBz9-1g@mail.gmail.com>
 <201408152149.44283.arnd@arndb.de>
Message-ID: <20140815231925.GO17528@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 15, 2014 at 09:49:44PM +0200, Arnd Bergmann wrote:

> Agreed. I think we had already concluded previously when discussing this
> patch that the clock management in APCI-5.1 should not be used on ARM64,
> but I think there is a problem one level deeper: The 5.0 and 5.1 versions
> apparently add a lot of new features that are meant for either ARM64
> servers or embedded x86 machines. These two typically have conflicting
> requirements, and it would be better for the specification itself to
> provide clearer statements to which parts apply in what use case rather
> than us (the Linux people) making claims about what parts of the spec
> are acceptable or not.

> There are already two specified classes of systems, the legacy x86
> and itanium machines, and the "reduced hardware" profile, which
> apparently covers both of the new types of machines mentioned above.

We also have legacy machines taking bits of the new stuff to contend
with.

> What would be the process to get a clarification into the next version
> of ACPI that makes them more distinct?

I agree with this, I actually had some patches come in this week which
seem to be worse than anything we've talked about and were intended just
key off DMI data instead of any form of platform data AFAICT.  The
pushback was that the Windows driver was doing this and the BIOS wasn't
about to change for us.  I'm not really convinced that waving some Linux
internal document about ARM servers at them is going to be terribly
persuasive to get them to improve future systems.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140816/83150d07/attachment.sig>
