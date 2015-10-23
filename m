From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 23 Oct 2015 10:09:29 +0200
Subject: [PATCH stable/v4.2.y] ARM: ux500: simplify secondary CPU boot
In-Reply-To: <20151023012257.GA26455@kroah.com>
References: <1445554568-4871-1-git-send-email-khilman@kernel.org>
 <20151023001754.GB10983@kroah.com>
 <CAMAWPa9aJRa=7JQU4xjHG8mGhMsnC=7st0tLEPpe8TQKGztC9w@mail.gmail.com>
 <20151023012257.GA26455@kroah.com>
Message-ID: <CACRpkdaKVK7SZCK3+2VNcFy20ULz33PSUiG03x-PEz-GsCVKUg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 23, 2015 at 3:22 AM, Greg KH <greg@kroah.com> wrote:
> On Thu, Oct 22, 2015 at 06:15:04PM -0700, Kevin Hilman wrote:
>> On Thu, Oct 22, 2015 at 5:17 PM, Greg KH <greg@kroah.com> wrote:
>> > On Thu, Oct 22, 2015 at 03:56:08PM -0700, Kevin Hilman wrote:
>> >> From: Linus Walleij <linus.walleij@linaro.org>
>> >>
>> >> This removes a lot of ancient cruft from the Ux500 SMP boot.
>> >> Instead of the pen grab/release, just point the ROM to
>> >> secondary_boot() and start the second CPU there, then send
>> >> the IPI.
>> >>
>> >> Use our own SMP enable method. This enables us to remove the
>> >> last static mapping and get both CPUs booting properly.
>> >>
>> >> Tested this and it just works.
>> >>
>> >> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>> >> Signed-off-by: Olof Johansson <olof@lixom.net>
>> >> (cherry picked from commit c00def71efd919e8ae835a25f4f4c80a4b2d36d3)
>> >> Cc: <stable@vger.kernel.org> # v4.2+
>> >> Signed-off-by: Kevin Hilman <khilman@linaro.org>
>> >> ---
>> >> This patch was the 2nd in a 2-patch series.  Only the 1st patch made it
>> >> into v4.2, but this one is also needed for booting on the ste-snowball.
>> >>
>> >>  arch/arm/mach-ux500/Makefile     |   2 +-
>> >>  arch/arm/mach-ux500/cpu-db8500.c |   1 -
>> >>  arch/arm/mach-ux500/headsmp.S    |  37 -----------
>> >>  arch/arm/mach-ux500/platsmp.c    | 132 ++++++++++++---------------------------
>> >>  arch/arm/mach-ux500/setup.h      |   1 -
>> >>  5 files changed, 40 insertions(+), 133 deletions(-)
>> >>  delete mode 100644 arch/arm/mach-ux500/headsmp.S
>> >
>> > This looks to me like a "new feature", is it a regression from something
>> > that used to work in 4.1?
>>
>> I guess Linus W. will have to explain better, but I'll try...
>>
>> it's the 2nd part of a 2-part fix that was submitted for v4.2, but
>> only the 1st part made it in because it was late for the merge window.
>
> That doesn't really sound like Documentation/stable_kernel_rules.txt
> material...

It is. Both patches *should* have gone in the merge window, but
because of a misunderstanding and oversight, one of them were
missed, so half of the two-part solution was merged, and unfortunately
merging half of it boot-regressed the platform.

Yours,
Linus Walleij
