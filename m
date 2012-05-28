From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Mon, 28 May 2012 15:29:18 +0530
Subject: [PATCHv9 02/10] I2C: OMAP: Fix the mismatch of pm_runtime enable
 and disable
In-Reply-To: <87wr3zkjp7.fsf@ti.com>
References: <1335969135-20858-1-git-send-email-shubhrajyoti@ti.com>
 <1335969135-20858-3-git-send-email-shubhrajyoti@ti.com>
 <87wr3zkjp7.fsf@ti.com>
Message-ID: <4FC34C76.402@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 26 May 2012 03:27 AM, Kevin Hilman wrote:
> Looks right.
>
> Can you be more specific in the changelog about when the errors/warning
> happens?
By the way the count cribs Unbalanced pm_runtime_enable!
is what happens.

I found it by review, I did the testing with this patch.

Since there was an access without get_sync I was seeing
some other issues.

Did not test with the fix and without this patch.
>   e.g. why pm_runtime_enable() is called again?  Is this on
> module unload/reload?
>
> Other than that
>
> Acked-by: Kevin Hilman <khilman@ti.com>
Thanks.
