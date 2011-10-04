From: khilman@ti.com (Kevin Hilman)
Date: Tue, 04 Oct 2011 13:47:48 -0700
Subject: [PATCH 1/4] ARM: OMAP3 PM: Fix IO Daisychain sequence
In-Reply-To: <1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
	(Vishwanath BS's message of "Tue, 4 Oct 2011 23:22:01 +0530")
References: <1317750724-32553-1-git-send-email-vishwanath.bs@ti.com>
	<1317750724-32553-2-git-send-email-vishwanath.bs@ti.com>
Message-ID: <87r52s8owb.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishwa,

Vishwanath BS <vishwanath.bs@ti.com> writes:

> As per OMAP3630 TRM Section 3.5.7.2.2, the right sequence for enabling IO Daisy
> chain is "The I/O wake-up scheme is enabled by triggering the I/O daisy chain
> control (Wu clock) by programming a dedicated register
> (PRCM.PM_WKEN_WKUP[16] EN_IO_CHAIN) in the PRCM module.Software must wait for
> the I/O daisy chain to complete before it transitions the PER domain to a
> nonfunctional state. This is done by polling a dedicated status bit in the PRCM
> module (PRCM.PM_WKST_WKUP[16] ST_IO_CHAIN). This status bit must be cleared by
> software when the bit is read to  1".
>
> The original code was polling on a wrong register which is fixed in this patch.
> Also omap3_enable_io_chain is made non static as it's going to be used in
> subsequent patches.
>  
> Signed-off-by: Vishwanath BS <vishwanath.bs@ti.com>

A fix for this was posted[1] by Mohan V (added to Cc) back in June.  It
recieved a few minor comments but an updated version was never posted.

Maybe you can ping Mohan or update that version fixing the comments
mentioned in that thread.

Thanks,

Kevin

[1] http://marc.info/?l=linux-omap&w=2&r=1&s=%27Mohan+V%27&q=b
