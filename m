From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Nov 2013 21:58:32 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
Message-ID: <201311152158.32644.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 15 November 2013, Olof Johansson wrote:
> So, I'm strongly urging that whatever the server guys try to do, it
> will in the end result in the ACPI data being translated into DT
> equivalents, such that the kernel only needs to handle data via DT.

I don't think that a translation layer is the answer, I see the problem
more in things that cannot be translated automatically. The parts that
are similar enough to allow translation could also just be handled by
a thin abstraction layer in the kernel, which I think we will see
on embedded x86 with DT-in-ACPI-syntax.

I think we can still treat ACPI on ARM64 as a beginner's mistake and
provide hand-written DT blobs for the few systems that start shipping
with that. The main reason for doing it in the first place was the
expected number of Windows RT servers, but WinRT isn't doing well
at the moment, so it's not unreasonable to assume it's going the same
way as WinRT tablets.

During the kernel summit, Grant (as one of the proponents of doing
ACPI on ARM) already mentioned that he only sees this as viable
on PC-like systems. My feeling is that when (if?) AMD or someone else
comes out with a server system where they basically replace the
x86 core with an ARM one but keep the system design, there won't
be much to describe in terms of internal components anyway, and also
no need to translate a lot of device information -- everything is
already a PCI device in that case and does not get handled through
the platform bus. However, until we see code or system-level specs
for such a system, I'd rather keep ACPI out of the ARM kernel so we
don't give people the wrong ideas.

	Arnd
