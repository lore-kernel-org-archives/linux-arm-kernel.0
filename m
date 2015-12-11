From: kvalo@codeaurora.org (Kalle Valo)
Date: Fri, 11 Dec 2015 11:50:37 +0000 (UTC)
Subject: iwlegacy: mark il_adjust_beacon_interval as noinline
In-Reply-To: <36263581.L8412YxJjp@wuerfel>
Message-ID: <20151211115037.B4125141D60@smtp.codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> With the new optimized do_div() code, some versions of gcc
> produce obviously incorrect code that leads to a link error
> in iwlegacy/common.o:
> 
> drivers/built-in.o: In function `il_send_rxon_timing':
> :(.text+0xa6b4d4): undefined reference to `____ilog2_NaN'
> :(.text+0xa6b4f0): undefined reference to `__aeabi_uldivmod'
> 
> In a few thousand randconfig builds, I have seen this problem
> a couple of times in this file, but never anywhere else in the
> kernel, so we can try to work around this in the only file
> that shows the behavior, by marking the il_adjust_beacon_interval
> function as noinline, which convinces gcc to use the unoptimized
> do_div() all the time.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Acked-by: Nicolas Pitre <nico@linaro.org>
> Acked-by: Stanislaw Gruszka <sgruszka@redhat.com>

Thanks, applied to wireless-drivers-next.git.

Kalle Valo
