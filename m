From: kgene.kim@samsung.com (Kukjin Kim)
Date: Wed, 21 Dec 2011 16:25:53 +0900
Subject: [PATCH v2 0/4] Implement RTC support for S3C2443/S3C2416/S3C2450
In-Reply-To: <201112121543.42299.heiko@sntech.de>
References: <201112121543.42299.heiko@sntech.de>
Message-ID: <064801ccbfb1$c5d48e60$517dab20$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> Similar to the ADC the RTC of S3C2443 and S3C2416/2450 has some slight
> variances when compared to the existing types.
> 
> This series adds support for those SoCs.
> 
> As with the ADC patches, these changes where tested on S3C2416 hardware.
> The S3C2443 quirks are a subset of those and are done according to the
> datasheet, but not tested on real hardware (as I do not own a S3C2443
> device).
> 
> changes since v1:
> address comments from Thomas Abraham, reducing number of ifdefs and
> duplicate code
> 
> 
> Heiko Stuebner (4):
>   ARM: SAMSUNG: cleanup of rtc register definitions
>   rtc-s3c: make room for more variants in devicetree block
>   rtc-s3c: add variants for S3C2443 and S3C2416
>   ARM: S3C2443/S3C2416: add s3c_rtc_setname and rename rtc devices
> 
>  arch/arm/mach-s3c2416/s3c2416.c               |    2 +
>  arch/arm/mach-s3c2443/s3c2443.c               |    2 +
>  arch/arm/plat-samsung/include/plat/regs-rtc.h |   92
+++++++++++++++------
> ---
>  arch/arm/plat-samsung/include/plat/rtc-core.h |   27 +++++++
>  drivers/rtc/rtc-s3c.c                         |   74 ++++++++++++++++----
>  5 files changed, 149 insertions(+), 48 deletions(-)
>  create mode 100644 arch/arm/plat-samsung/include/plat/rtc-core.h
> 
> --
> 1.7.5.4

Hi Heiko,

There were small comments on 1st patch and others looks ok to me.
If you're ok on my comments, please re-send it so that I can request to pull
this series to Alessandro or Andrew with my ack.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
