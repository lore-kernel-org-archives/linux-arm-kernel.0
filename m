From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Sat, 17 May 2014 01:21:08 +0300
Subject: [PATCH v2] ARM: imx: fix error handling
In-Reply-To: <20140516192451.GP16662@pengutronix.de>
References: <1400234045-6022-1-git-send-email-emilgoode@gmail.com>
 <20140516192451.GP16662@pengutronix.de>
Message-ID: <20140516222108.GI8897@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 16, 2014 at 09:24:51PM +0200, Uwe Kleine-K?nig wrote:
> I didn't check if it is easily possible, but converting this file to use
> platform_device_register_full might simplify it considerably.

In a separate patch, though, please.

> 
> I'm not sure this fix is critical, because the problem happens if an
> allocation during boot fails. But still, if you want to get this fix
> into a stable release, you should simplify it, i.e. don't do the code
> reorganisations. (Also the "more clear" part seems to be subjective, I
> like the error handling better as it is now. But that might only be me.)

Emil's error handling is done exactly in the correct way...  The error
path and success path are separate.  Unwinding in the reverse order.
The label names describe the label locations.  Most days I spend hours
looking at linux kernel error handling and I can assure you that
sensible labels like this are a rare and wonderful gift.

It's hard for me to imagine how anyone could defend the original error
handling.  The label was "err".  The error handling was randomly plopped
in the middle of the success handling.  Whenever I see new "creative"
error handling like this it drives me nuts because obviously it's going
to be buggy like a swamp picnic.

regards,
dan carpenter
