From: khilman@ti.com (Kevin Hilman)
Date: Fri, 25 May 2012 15:13:36 -0700
Subject: [PATCHv9 00/10] I2C fixes
In-Reply-To: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 (Shubhrajyoti D.'s message of "Wed, 2 May 2012 20:02:05 +0530")
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
Message-ID: <87r4u7j4dr.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Shubhrajyoti D <shubhrajyoti@ti.com> writes:

> The patch series does the following
>
> - Warn fixes if CONFIG_PM_RUNTIME is not selected.
> - In case of i2c remove register access was done without any
>  get_sync fix the same.
> - Folds a patch from Tasslehoff to prevent any merge conflicts.
> - Prevents the XDUF flag to be set if the underflow condition is not met.
> - As per discussion in [1] .Adds a patch to rename the 1p153 errata and
>  use the unique id instead as the section number in the recent errata
>  docs has changed.
>
> v9:
> Fix the comments from Wolfram Sang
>
> [1] http://www.spinics.net/lists/linux-i2c/msg07607.html
>
> Tested on omap4sdp and omap3sdp.

Can you also describe how it was tested?  

With the runtime PM changes, does it still hit full-chip retention in
idle and suspend after these changes?

I had a few minor comments on this version, otherwise feel free add

Reviewed-by: Kevin Hilman <khilman@ti.com>

That being said, before this is merged, I woudl like to see some more
non-author Tested-bys.  We've been having lots of regressions of late
from OMAP drivers that are not being sufficiently tested before
merging.  We need to ensure proper testing before merge.

Other testers should also report what platforms they tested on, and how
it was tested.

Thanks,

Kevin
