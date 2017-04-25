From: will.deacon@arm.com (Will Deacon)
Date: Tue, 25 Apr 2017 13:13:28 +0100
Subject: [PATCH] arm64: Add ASM modifier for xN register operands
In-Reply-To: <20170424191345.GM128305@google.com>
References: <20170420183053.718-1-mka@chromium.org>
 <20170424170009.GT12323@arm.com>
 <CAKv+Gu_Ms73qfFFjmhkwF9Rh2jBM6Cx9LfuSHPUnXv0GTR1z7w@mail.gmail.com>
 <20170424173413.GW12323@arm.com>
 <20170424191345.GM128305@google.com>
Message-ID: <20170425121328.GH24484@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 24, 2017 at 12:13:45PM -0700, Matthias Kaehlcke wrote:
> El Mon, Apr 24, 2017 at 06:34:14PM +0100 Will Deacon ha dit:
> > On Mon, Apr 24, 2017 at 06:22:51PM +0100, Ard Biesheuvel wrote:
> > > AIUI, Clang now always complains for missing register width modifiers,
> > > not just for placeholders that resolve to a 32-bit (or smaller)
> > > quantity.
> > 
> > Ok, in which case this patch is incomplete as there's a bunch of asm that
> > isn't updated (e.g. spinlock.h).
> 
> Sorry, my grep pattern was a bit naive and didn't take multiline
> inline assembly into account.

Ah, right, so you were trying to fix everything but just missed stuff. Maybe
it's best to grep for 'asm.*(' and filter out the false positives.

> If you are ok with adding modifiers everywhere I'll add the missing
> bits, otherwise I'll rework the patch to only change the instances
> where clang emits the warning.

Fixing the issue everywhere is probably best. You might also need to look
under drivers/.

Will
