From: olof@lixom.net (Olof Johansson)
Date: Mon, 24 Aug 2015 14:44:21 -0700
Subject: [PATCH 00/18] ARM: use const and __initconst for smp_operations
In-Reply-To: <20150824212127.GH7557@n2100.arm.linux.org.uk>
References: <1440390978-22796-1-git-send-email-yamada.masahiro@socionext.com>
 <CAOesGMjku09wsUmwooq2ZXLyV7CPfioi0oAV5EgvW_wE98VYeg@mail.gmail.com>
 <20150824212127.GH7557@n2100.arm.linux.org.uk>
Message-ID: <CAOesGMgayep0EgCAdDWSujmiycDqtFUb0iKg-aioJqyzHRectA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 24, 2015 at 2:21 PM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Mon, Aug 24, 2015 at 02:12:06PM -0700, Olof Johansson wrote:
>> Easiest of all would probably be to get the sub-arch patches into one
>> release, then switch the prototypes and function definitions in the
>> next. If you switch prototypes first you'll get a bunch of warnings,
>> right?
>
> Wrong way around. :)
>
> If you change the sub-arches to declare the smp operations as const,
> and try and pass them into a function which doesn't take a const-pointer,
> you'll get a warning.  The core bits need to go in first before the
> sub-arch patches.

Ah yes, my bad.

> I think the series has limited value - it allows us to (a) check that a
> small quantity of code doesn't write to these things, and (b) allows us
> to move the SMP operations structure from __initdata to __initconstdata.
> It's still going to end up in the init region which is read/write in any
> case, and still gets thrown away.
>
> Given where we are, I don't think we need to rush this in during the
> last week before the merge window opens, even though it's trivial.

Agreed. So if you pick it up for 4.4, we'll get the rest for 4.5.


-Olof
