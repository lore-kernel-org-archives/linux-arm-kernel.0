From: pavel@denx.de (Pavel Machek)
Date: Mon, 28 Jan 2013 11:45:52 +0100
Subject: [PATCHv1 for soc 4/5] arm: Add v7_invalidate_l1 to cache-v7.S
In-Reply-To: <51020D20.60505@wwwdotorg.org>
References: <1359075633-13502-1-git-send-email-dinguyen@altera.com>
 <1359075633-13502-5-git-send-email-dinguyen@altera.com>
 <51020D20.60505@wwwdotorg.org>
Message-ID: <20130128104552.GB6073@amd.pavel.ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 2013-01-24 20:42:08, Stephen Warren wrote:
> On 01/24/2013 05:00 PM, dinguyen at altera.com wrote:
> > From: Dinh Nguyen <dinguyen@altera.com>
> > 
> > mach-socfpga is another platform that needs to use
> > v7_invalidate_l1 to bringup additional cores. There was a comment that
> > the ideal place for v7_invalidate_l1 should be in arm/mm/cache-v7.S
> 
> > diff --git a/arch/arm/mach-tegra/headsmp.S b/arch/arm/mach-tegra/headsmp.S
> 
> > -ENTRY(v7_invalidate_l1)
> > -        mov     r0, #0
> 
> Unfortunately, there's a patch in the Tegra tree for 3.9 that moves that
> function from headsmp.S to reset-handler.S, so this patch will conflict.
> How do you want to handle that?

Drop the patch from Tegra tree and merge this one there? Having three
copies of code is not nice to start with, no matter where it is...
								Pavel
-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
