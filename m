From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 19 Nov 2013 13:48:44 +0100
Subject: ACPI vs DT at runtime
In-Reply-To: <201311182247.03540.david.goodenough@btconnect.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131118213256.8EC15C401C6@trevor.secretlab.ca>
 <201311182247.03540.david.goodenough@btconnect.com>
Message-ID: <201311191348.44660.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 18 November 2013, David Goodenough wrote:
> Would it not be possible to have ACPI read the hardware configuration
> from the DT, and provide whatever services it wants, while also allowing
> the kernel to retain the DT for its hardware config?  I suppose the only
> thing that would be needed would be some way to mark paricular bits of
> hardware (I am largely thinking of the things lmsensors deals with) as
> being used by ACPI and being off limits to the kernel.

While that may be possible, I don't see what problem that solves. Nobody
has so far explained what problem they want to solve by using ACPI. The
only reason we are discussing this is Jon's statement that "everybody
will use it". For any specific thing you might want to do in ACPI while
leaving the rest in DT, I suspect there is an easier solution in using
just DT.

Since you seem to have something specific in mind, can you elaborate on
why you think lmsensors (or any other device you can think of) would
benefit from ACPI?

	Arnd
