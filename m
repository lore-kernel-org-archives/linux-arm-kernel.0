From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 08 Dec 2015 16:14:27 +0100
Subject: [PATCH 01/19] ASoC: da7218: avoid 64-bit compile warning
In-Reply-To: <3548574.qiC2AlzHH4@wuerfel>
References: <3548574.qiC2AlzHH4@wuerfel>
Message-ID: <6859274.7lKHWvMkkW@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 08 December 2015 16:12:54 Arnd Bergmann wrote:
> When building the da7218 driver on a 64-bit architecture, we get
> a harmless warning:
> 
> sound/soc/codecs/da7218.c: In function 'da7218_of_get_id':
> sound/soc/codecs/da7218.c:2261:10: warning: cast from pointer to integer of different size [-Wpointer-to-int-cast]
> 
> This changes the code to use uintptr_t to ensure we have an integer
> type of the same size as a pointer and won't get a warning on any
> architecture.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 4d50934abd22 ("ASoC: da7218: Add da7218 codec driver")

Please ignore the "[01/19]", I didn't mean to send this as a series, so just
apply it directly. I happen to send 19 patches to different maintainers
and misused git-format-patch.

	Arnd
