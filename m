From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Sat, 5 Mar 2011 13:49:00 +0530
Subject: [PATCH] ARM: twd: Adjust localtimer frequency with
	cpufreqnotifiers
In-Reply-To: <AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
References: <1290060899-9786-1-git-send-email-ccross@android.com><AANLkTimCuV5N0jr8c949uONEvieQ5MDZ9KHDXtneG5AT@mail.gmail.com><4D70BE9D.4000507@stericsson.com><AANLkTin7ZXYALOy_jk1uR3SbZA51nSnU-ncSjG+n_RPn@mail.gmail.com><4D714C17.7080102@gmail.com>
	<AANLkTims4e7o0sPxVnN0D1mNWDH7uC9q=pBQrBoad2os@mail.gmail.com>
Message-ID: <eea425c066cc69c30f118fb102fff43e@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Collin, Rob,
> -----Original Message-----
> From: linux-arm-kernel-bounces at lists.infradead.org [mailto:linux-
> arm-kernel-bounces at lists.infradead.org] On Behalf Of Colin Cross
> Sent: Saturday, March 05, 2011 3:03 AM
> To: Rob Herring
> Cc: Russell King; Srinidhi KASAGAR; Harald Gustafsson; Linus
> Walleij; linux-kernel at vger.kernel.org; Rickard ANDERSSON; Varun
> Swara; Catalin Marinas; martin persson; linux-arm-
> kernel at lists.infradead.org
> Subject: Re: [PATCH] ARM: twd: Adjust localtimer frequency with
> cpufreqnotifiers
>
[...]

>
> Using a clock along with the cpufreq notifiers would simplify my
> patch
> some.  Maybe we can use the traction this patch has among platforms
> that use the twd to get the necessary clocks added.  Can you post a
> version of your patch that assumes the presence of a twd clock, and
> I'll work on getting the necessary clocks added and updating my
> patch on top of yours?
>

Some time back I also fixed the TWD scaling problem based on more
or less similar idea of pre-scaler and CPUFREQ notifiers.
Rob's clock idea was neat and useful to re-calibration

While doing this patch for OMAP I also found that
CPUFREQ notifiers does delays scaling timer frequency
and there is a tick deviation(3-4 ms) around 1st tick and
last tick around twd rescaling.

Another issue was not able to select higher fixed twd rate
and found fix for the same.

Regards,
Santosh
