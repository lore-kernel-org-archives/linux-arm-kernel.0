From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 23 Aug 2011 18:01:20 +0200
Subject: [PATCH v2 1/4] ARM: CSR: add rtc i/o bridge interface for
	SiRFprimaII
In-Reply-To: <1314080152-30503-2-git-send-email-Baohua.Song@csr.com>
References: <1314080152-30503-1-git-send-email-Baohua.Song@csr.com>
	<1314080152-30503-2-git-send-email-Baohua.Song@csr.com>
Message-ID: <201108231801.20595.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 August 2011, Barry Song wrote:
> From: Zhiwu Song <zhiwu.song@csr.com>
> 
> The module is a bridge between the RTC clock domain and the CPU interface
> clock domain. ARM access the register of SYSRTC, GPSRTC and PWRC through
> this module.
> 
> Signed-off-by: Zhiwu Song <zhiwu.song@csr.com>
> Signed-off-by: Barry Song <Baohua.Song@csr.com>
> ---

Acked-by: Arnd Bergmann <arnd@arndb.de>

Looks basically good now. Aside from the trivial things that Jamie
already pointed out, there is one more that I noticed:

> +
> +void __iomem *sirfsoc_rtciobrg_base;
> +static DEFINE_SPINLOCK(rtciobrg_lock);

sirfsoc_rtciobrg_base should be static as well. No other code can
properly access it anyway since the lock is static, too.

	Arnd
