From: dinguyen@altera.com (Dinh Nguyen)
Date: Mon, 28 Jan 2013 11:35:12 -0600
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <5106B4FD.4030108@wwwdotorg.org>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
 <51020D20.60505@wwwdotorg.org> <20130128104552.GB6073@amd.pavel.ucw.cz>
 <5106B4FD.4030108@wwwdotorg.org>
Message-ID: <1359394512.17735.43.camel@linux-builds1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Mon, 2013-01-28 at 10:27 -0700, Stephen Warren wrote:
> On 01/28/2013 03:45 AM, Pavel Machek wrote:
> > On Thu 2013-01-24 20:42:08, Stephen Warren wrote:
> >> On 01/24/2013 05:00 PM, dinguyen at altera.com wrote:
> >>> From: Dinh Nguyen <dinguyen@altera.com>
> >>>
> >>> mach-socfpga is another platform that needs to use
> >>> v7_invalidate_l1 to bringup additional cores. There was a comment that
> >>> the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> >>
> >>> diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> >>
> >>> -ENTRY(v7_invalidate_l1)
> >>> -        mov     r0, #0
> >>
> >> Unfortunately, there's a patch in the Tegra tree for 3.9 that moves that
> >> function from headsmp.S to reset-handler.S, so this patch will conflict.
> >> How do you want to handle that?
> > 
> > Drop the patch from Tegra tree and merge this one there? Having three
> > copies of code is not nice to start with, no matter where it is...
> 
> Well, I guess for other reasons rebasing the Tegra tree is useful for a
> few dependencies, so I'll drop that part of the patch which moves
> v7_invalidate_l1() from one file to another, so there shouldn't be any
> conflicts, and you can feel free to take this series through whatever
> tree you want.
> 
> I haven't tested this patch yet though, to see whether the slight
> differences in the code in your patch mentioned in the other sub-thread
> affect Tegra at all. Hopefully I can test this later today.

Shawn Guo mentioned that the instruction to invalidate I-Cache is
unnecessary becauce of this commit: 612539e (ARM: 7296/1: proc-v7.S:
remove HARVARD_CACHE preprocessor guards)

So I'll send v2 without the extra instruction.

Thanks,
Dinh
> 
