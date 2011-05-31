From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Tue, 31 May 2011 10:30:52 +0530
Subject: [PATCH] ARM: EXYNOS4: Fix secondary CPU boot after wake-up
In-Reply-To: <20110530215404.GB21382@n2100.arm.linux.org.uk>
References: <1306746781-21511-1-git-send-email-inderpal.s@samsung.com>
	<4DE36589.4080709@ti.com>
	<20110530215404.GB21382@n2100.arm.linux.org.uk>
Message-ID: <4DE47604.6070405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/31/2011 3:24 AM, Russell King - ARM Linux wrote:
> On Mon, May 30, 2011 at 03:08:17PM +0530, Santosh Shilimkar wrote:
>> When do you plan to fix the SGI usage as discussed
>> in above thread. I thought SGI1 usage was ok for OMAP,
>> realview/versatile and MSM.
>
> I'd like the use of the arbitary SGI1 to fade away, to be replaced with
> something a little saner (eg, SGI0 being the first SGI).  That just
> means you'll end up with a warning about SGI0 instead.  Let's just
> ignore them for the time being (but please change to SGI0 anyway.)

I mean SGIO. SGI1 was typo. Ignoring that warning isn't good idea.
Platforms which do aggressive CPU offline/online, will keep
getting this noise and hence need to be fixed.

How about my patch which was marking this as a wakeup
IPI instead of unknown one. Ofcourse with wakeup SGI
being used will be SGI0 instead of current SGI1.

If you are ok with it I can send an RFC patch ?

Regards
Santosh
