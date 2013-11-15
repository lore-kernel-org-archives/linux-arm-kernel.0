From: olof@lixom.net (Olof Johansson)
Date: Thu, 14 Nov 2013 17:44:10 -0800
Subject: ACPI vs DT at runtime
Message-ID: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The more I start to see early UEFI/ACPI code, the more I am certain
that we want none of that crap in the kernel. It's making things
considerably messier, while we're already very busy trying to convert
everything over and enable DT -- we'll be preempting that effort just
to add even more boilerplate everywhere and total progress will be
hurt.

The server guys really want UEFI for their boot protocols,
installation managers, etc, etc. That's fine, let them do that, but
that doesn't mean we need to bring the same APIs all the way into the
kernel.

So, I'm strongly urging that whatever the server guys try to do, it
will in the end result in the ACPI data being translated into DT
equivalents, such that the kernel _only_ needs to handle data via DT.

Just like PowerPC scrapes the OpenFirmware client interface to build a
flat device tree, we should add a pre-boot stage that scrapes
ACPI/UEFI data and constructs an appropriate device-tree. We can still
bring over ACPI methods and represent those in the DT, but we should
_not_ have two native interfaces.

It might be done via having a skeleton/framework DT for the vendor
platform that is updated via UEFI/ACPI data, or it might be
constructed entirely out of tables coming from firmware. I don't care
about the methods for how it is done, but I do feel strongly that we
should _not_ introduce a second API for everything. I can't think of a
single good reason to do it.


[There, commence centithread]

-Olof
