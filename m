From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 17 Dec 2015 10:46:49 +0100
Subject: block layer bug with 4.4-rc3+
In-Reply-To: <56728044.7090906@arm.com>
References: <566FF3ED.1000503@arm.com> <1885710.UNGYhDGGcI@wuerfel>
 <56728044.7090906@arm.com>
Message-ID: <4730511.HtLlToyPh4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 17 December 2015 09:28:36 Andre Przywara wrote:
> 
> So it was running for almost a day without LPAE now, but with highmem,
> and the bug didn't show up. So for the time being I'd avoid another test
> run without highmem, as LPAE alone is sufficient to trigger it.

There is clearly no need to try with both LPAE and HIGHMEM disabled, that
would almost certainly not bring the bug back.

A more useful test might be to try Cubieboard with LPAE enabled, possibly
with LPAE and no highmem, to rule out the possibility that the bug just
gets less likely when you have less highmem.

> Also it seems that CONFIG_HIGHMEM is selected by MULTI_V7, so I can't
> configure it out for this box, but would have to restrict memory to
> 768M, I guess.
> 
> Next I will try some tracing as Ming suggested.

It should not be selected by MULTI_V7, the only 'select HIGHMEM' statement
I see is for ARCH_OMAP2PLUS_TYPICAL, and that is not a mandatory option
for anything, it just turns on a few things that are generally useful.

	Arnd
