From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Sat, 23 Nov 2013 11:39:04 -0700
Subject: ACPI
In-Reply-To: <201311231011.45892.arnd@arndb.de>
References: <F5C3F66D-C7C0-494A-8561-77E1DE0FA103@jonmasters.org>
 <528FC5C1.1080403@jonmasters.org> <528FCEA6.1060602@jonmasters.org>
 <201311231011.45892.arnd@arndb.de>
Message-ID: <20131123183904.GB20790@obsidianresearch.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 23, 2013 at 10:11:45AM +0100, Arnd Bergmann wrote:

> I've talked in the past to people who got your message about ACPI
> but not the rest and that are now struggling in a very misguided
> attempt to bring ACPI to systems that are anything but boring and
> that will cause real headaches for years on both developers and users
> if they actually end up shipping.

I think a strong way to deal with this is to NAK any ACPI related
changes that are not implementing a published, released spec.

Forcing ACPI development to go through a multi-vendor standards
process, while allowing DT to be handled internally to the kernel
should provide enough incentive to direct people to the correct choice
:)

However, fundamentally, that would mean that ACPI on the ARM is on-hold
from a kernel perspective until the first spec is released by the new
working group - and that would imply initial servers should plan to
boot using DT, and provide experimental ACPI. Similar to how x86
introduced ACPI.

The ACPI working group should also hear what kernel folks want to see
of ACPI eg no clk, regulator, gpio, etc bindings, use DT for that.

First gen servers that can't implement the spec have the DT escape
hatch while they make changes which should reduce the pressure on
kernel folks to accept inappropriate patches...

Jason
