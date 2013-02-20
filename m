From: tony@atomide.com (Tony Lindgren)
Date: Wed, 20 Feb 2013 08:09:53 -0800
Subject: [PATCH 2/9] ARM: OMAP1: PM: Remove bogus fiq_[enable/disable]
 tuple
In-Reply-To: <1361373527-21695-3-git-send-email-santosh.shilimkar@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-3-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <20130220160953.GO5724@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

* Santosh Shilimkar <santosh.shilimkar@ti.com> [130220 07:21]:
> On OMAP platform, FIQ is reserved for secure environment only. If at all
> the FIQ needs to be disabled, it involves going through security
> API call. Hence the local_fiq_[enable/disable]() in the OMAP code is bogus.
> 
> So just get rid of it.

This is not true for all omaps, needs to be checked carefully
at what point it was made HS omap only. We have at least
mach-omap1//ams-delta-fiq.c that's being used.

Regards,

Tony
