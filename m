From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 30 Apr 2012 18:29:19 +0530
Subject: [PATCH 0/6] ARM: OMAP: hwmod: remove runtime cpu_is checking
In-Reply-To: <1335557140-10854-1-git-send-email-khilman@ti.com>
References: <1335557140-10854-1-git-send-email-khilman@ti.com>
Message-ID: <4F9E8CA7.8050700@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 28 April 2012 01:35 AM, Kevin Hilman wrote:
> This series attempts to remove all the runtime cpu_is* checking in
> omap_hwmod.c in favor of using function pointers initialized at init
> time.
> 
> This series was motivated by the addition of support for the AM335x
> series which was done by adding several more cpu_is* checks, and
> provided the proverbial straw that broke the camel's back.  
> 
> In addition to the cleanup, this provides a much cleaner way of adding
> additional SoC support since it no longer requires adding additional
> runtime cpu_is* checks.
> 
> Boot tested on OMAP3530/Overo and OMAP4430/Panda.
> 
I was looking at some of these while trying to OMAP5
support. Indeed the cpu_is_* is becoming increasingly
no maintanable and ugly. Thanks for the series.

Have reviewed the series & tested it on OMAP4430 SDP.
Firstly I tried applying the branch against mainline
only to realise that it does depend on Paul's
earlier series. So used directly your branch
"for_3.5/cleanup/hwmod-cpu-is" to test it out.

Only one comment on function names considering
OMAP4/5 compatibility.
Should omap4_*() defined in this series should be
called omap4plus_*() or similar considering they can
be directly used on OMAP5 devices too.

Otherwise FWIW,
Reviewed-tested-by: Santosh Shilimkar <santosh.shilimkar@ti.com>

Regards
santosh
