From: arnd@arndb.de (Arnd Bergmann)
Date: Sun, 19 Jun 2016 16:50:19 +0200
Subject: [PATCH v3 0/5] i.MX L2-cache code cleanups and performance tweaks
In-Reply-To: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
References: <1466296268-27099-1-git-send-email-andrew.smirnov@gmail.com>
Message-ID: <114981982.VXDIiN0rdz@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday, June 18, 2016 5:31:01 PM CEST Andrey Smirnov wrote:
> Hi everyone,
> 
> Here's the second version of i.MX L2-cache related patches. Here's
> what's new from v2:
> 
>        - Generic ARM patches were split inot a separte series
> 
>        - Typo and whitespace fixes (as per Uwe's suggestions)
> 
>        - Re-ordered l2c_aux_val, and l2c_aux_mask are initializers are placed
>          in the order of their declaration
> 
> Let me know if any more changes to the series are needed.

One more question, less about your patches than the existing code:

After going through the current users of l2x0_init for board files,
I noticed that imx35 enables l2x0 for both dts and all the board files
and has an arm,l210-cache node in its dts, but imx31 only enables
it for the board file and in the dt case doesn't init the cache nor
does it have the dts node.

I'm guessing this is a bug on i.mx31 dt support, right?

	Arnd
