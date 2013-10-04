From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 4 Oct 2013 12:41:28 +0100
Subject: Use of drivers/platform and matching include?
In-Reply-To: <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
References: <BC1C47B3-5412-4829-A1D9-AAB04694D1CC@codeaurora.org>
 <CAOesGMjJ6Uj0uGFJqtnWQyDW+tr6eLVWoHZ+B7uFna+L8N6E8Q@mail.gmail.com>
Message-ID: <20131004114128.GL12758@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 03, 2013 at 09:46:30AM -0700, Olof Johansson wrote:
> I don't have a good answer though. If it wasn't for the arm64 fork,
> locating these under arch/arm somewhere would really be the reasonable
> answer, like we used to do on powerpc. :(

Are you seriously suggesting going back to having drivers under arch/arm
because we can't find a home for them in the drivers subtree?

Having made a big thing about things as small as clock source drivers,
IRQ drivers and such like which "shouldn't be under arch/arm" and moving
them out, to then say about finding somewhere under arch/arm for drivers
is very much a case of double-standards.

I've heard this accusation that we have too many drivers in arch/arm
many times, and although we've made some progress getting things like
clock and IRQ drivers out of arch/arm, we're still a long way from
sorting that out.  Or maybe that original accusation was baseless for
modern kernels, based on the old 1.x days when we had a arch/arm/drivers
subdirectory which people have a hard time forgetting?

So, no, there will be no new drivers under arch/arm.  They must be in the
drivers subtree somewhere.
