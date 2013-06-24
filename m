From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Jun 2013 10:16:18 +0200
Subject: [GIT PULL] Keystone SOC support for 3.11
In-Reply-To: <20130624081057.GA11105@linaro.org>
References: <1371255346-3000-1-git-send-email-santosh.shilimkar@ti.com>
 <201306211819.36288.arnd@arndb.de> <20130624081057.GA11105@linaro.org>
Message-ID: <4545899.6e6jeG6NYZ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 June 2013 09:11:08 Steve Capper wrote:
> 
> Many apologies, I think this was introduced by my huge page patches. For
> transparent hugepages to function correctly, access flag faults need to be
> handled by do_page_fault rather than do_sect_fault. Even without THP enabled
> the standard page fault handler is safe to use, so I removed the do_sect_fault
> entry from fsr-3level.c.
> 
> Originally I had non-LPAE huge page code too in the series and one of those
> patches re-wired fsr-2level.c and then completely removed do_sect_fault.
>
> When I split the patch series I didn't spot that do_sect_fault was in limbo for
> LPAE.

Ok, I see.
 
> I think the do_sect_fault can safely be surrounded by #ifndef CONFIG_ARM_LPAE.
> Should I send a patch to do this?

Yes, that would be good. Please add it to Russell's patch tracker once
you get an ack.

	Arnd
