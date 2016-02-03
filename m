From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 03 Feb 2016 10:15:34 +0100
Subject: [PATCH] clk: vt8500: don't return possibly uninitialized data
In-Reply-To: <20160203113626.4a3f4f8a@v1ron-s7>
References: <4790407.6zgSQCdsSB@wuerfel> <2326140.nrZ9Ej2PSt@wuerfel>
 <20160203113626.4a3f4f8a@v1ron-s7>
Message-ID: <1624352.DBIo65mLZO@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 03 February 2016 11:36:26 Roman Volkov wrote:
> 
> Hi Arnd,
> 
> Thanks for fixing this code! Did someone reproduce this bug, or this
> is something theoretical, based on the code analysis? I just never
> heard about the issue. I can look into the code on the weekends too, I
> have WM8505\WM8650 machines to test.

I only fixed it after analysing the gcc warnings I got after Andrzej Hajda's
patch, and he also did it to fix the initial problem he found using
coccinelle, so I don't think anyone has run into the problem on live
hardware.

As long as all drivers ask for clock rates that are valid, you won't
see either problem.
 
> Is it enough to run the regular kernel build for WM8650 to see the
> warnings, or there are special options in the kernel to run the compiler
> test?

The warning is hidden if you build with -Os (CONFIG_CC_OPTIMIZE_FOR_SIZE),
and it may not happen with all gcc versions. I was using gcc-5.2.

	Arnd
