From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 11 Dec 2014 18:22:32 +0000
Subject: [PATCH] arm: mm: dump: don't skip final region
In-Reply-To: <20141208175503.GI11285@n2100.arm.linux.org.uk>
References: <1417782016-11825-1-git-send-email-mark.rutland@arm.com>
 <CAPvkgC1oOU_3D03ZV-uZqTW_DX8J74oGEKQZTTi2YrC+oSqJyA@mail.gmail.com>
 <20141208120537.GB21680@leverpostej>
 <CAPvkgC1HbuezEjmdUwVCM_Mic7Z5rF5BofSryQegiVOA08NwaA@mail.gmail.com>
 <20141208175503.GI11285@n2100.arm.linux.org.uk>
Message-ID: <20141211182232.GB13152@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 08, 2014 at 05:55:03PM +0000, Russell King - ARM Linux wrote:
> On Mon, Dec 08, 2014 at 05:46:45PM +0000, Steve Capper wrote:
> > After some head scratching....
> > 
> > Basically, the swapper_pg_dir will only contain kernel pgd entries. So
> > at the beginning where one would normally user-space entries in a pgd
> > table, there should be null entries that are skipped over. So yes, I
> > agree, we should be able to remove the USER_PGTABLES_CEILING check.
> 
> The check is there to avoid noting anything about the lower entries.
> There is the possibility for lower entries to contain something (the
> low vector mapping), though you're probably right that we should
> report those too.

Ok. I'll send out a v2 which removes both uses of USER_PGTABLES_CEILING
and repots all entries.

Thanks,
Mark.
