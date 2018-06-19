From: broonie@kernel.org (Mark Brown)
Date: Tue, 19 Jun 2018 12:56:08 +0100
Subject: [Dev] [PATCH 0/5] RFC: Mezzanine handling for 96boards
In-Reply-To: <20180619111018.r3m35g4ei6625pqz@holly.lan>
References: <20180618074556.6944-1-linus.walleij@linaro.org>
 <20180619111018.r3m35g4ei6625pqz@holly.lan>
Message-ID: <20180619115608.GA11230@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 19, 2018 at 12:10:18PM +0100, Daniel Thompson wrote:
> On Mon, Jun 18, 2018 at 09:45:51AM +0200, Linus Walleij wrote:

> > - I am especially curious about input from Andy and Mika from
> >   the Intel/ACPI camp on what they have seen for non-discoverable
> >   plug-in boards. Does this problem even exist in the Intel
> >   world, or not...

> I'm also interested in the "what about ACPI" question?

> Using C makes describing a board in ACPI fairly easy. AFAICT allocating
> IDs to a board rather than its included components is fairly natural for
> ACPI.

Yes, they have this problem - they have plug in modules on for example
the minnowboard and some of their other reference platforms.  They have
overlays working for ACPI, these have their own problems in that they
don't appear to have the equivalent of DMI data (at least the patches
people are sending indicates that they don't) which is unfortuate as the
idiomatic thing for ACPI is as you say to key huge chunks of data of
quirk tables based on the DMI information for their boards.

They don't to my knowledge have generic connectors or anything like
that, it's just patches to the base ACPI.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180619/fed9da48/attachment-0001.sig>
