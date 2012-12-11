From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Dec 2012 17:38:19 +0100
Subject: [RFC v1 01/16] lib: devres: don't enclose pcim_*() functions in
 CONFIG_HAS_IOPORT
In-Reply-To: <20121211162325.GR14363@n2100.arm.linux.org.uk>
References: <1354917879-32073-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <201212111043.50627.arnd@arndb.de> <20121211170338.4859ddf0@skate>
 <201212111615.03262.arnd@arndb.de>
 <20121211162325.GR14363@n2100.arm.linux.org.uk>
Message-ID: <20121211173819.6f2cf32b@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Tue, 11 Dec 2012 16:23:25 +0000, Russell King - ARM Linux wrote:

> > * ARCH_VEXPRESS should not select NO_IOPORT. It's generally wrong
> >   to select this in combination with ARCH_MULTIPLATFORM, when some
> >   of the other platforms you may enable actually have IOPORT mapping
> >   support.
> 
> No.  ARCH_VEXPRESS selects NO_IOPORT because it _does_ _not_ support
> PCI/ISA IO space.  That in itself is reasonable, but what isn't
> reasonable is the _negative_ logic being used.  Negative logic in
> the config system always tends to provoke this kind of sillyness
> because you're selecting something to be excluded which another
> platform may require.

Could you enlighten my very naive understanding of things about PCI/ISA
IO space? On x86, I seem to understand this is the separate address
space accessed by the special in/out CPU instructions. Are there ARM
platforms with the same sort of things?

As far as I understand, on my ARM Marvell system, everything is
memory-mapped, so there isn't such a separate PCI/ISA IO space.

Therefore, why would I need to "select HAVE_IOPORT" simply to be able
to build libata-sff.c, that is used for PCI drivers that work fine with
purely memory-mapped registers?

Sorry for the stupid/naive questions, but it'll definitely help to
understand the matter.

Thanks,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
