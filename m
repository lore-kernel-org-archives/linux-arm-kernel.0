From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 10 Aug 2016 13:40:13 +0300
Subject: [PATCH] video: s3c2410fb: Register cpufreq notifier only on
 S3C24xx
In-Reply-To: <1467031945-10486-1-git-send-email-k.kozlowski@samsung.com>
References: <1467031945-10486-1-git-send-email-k.kozlowski@samsung.com>
Message-ID: <48c0efad-875e-0a38-240f-d36e1c7f8d66@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 27/06/16 15:52, Krzysztof Kozlowski wrote:
> The driver registered for CPU frequency transitions to recalculate its
> clock when ARM clock frequency changes (ratio between frequencies of
> ARM's parent clock (fclk) and clock for peripherals remains fixed).
> 
> This is needed only on S3C24xx platform when cpufreq driver is enabled
> so limit the ifdef to respective cpufreq Kconfig.
> 
> Suggested-by: Marek Szyprowski <m.szyprowski@samsung.com>
> Signed-off-by: Krzysztof Kozlowski <k.kozlowski@samsung.com>
> ---
>  drivers/video/fbdev/s3c2410fb.c | 2 +-
>  drivers/video/fbdev/s3c2410fb.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Thanks, queued for v4.9.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160810/8d0941c3/attachment-0001.sig>
