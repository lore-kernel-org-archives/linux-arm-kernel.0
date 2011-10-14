From: kgene.kim@samsung.com (Kukjin Kim)
Date: Fri, 14 Oct 2011 16:14:11 +0900
Subject: [PATCH 0/8] S3C2416: Enable armdiv and armclk
In-Reply-To: <201109281217.33813.heiko@sntech.de>
References: <201109281217.33813.heiko@sntech.de>
Message-ID: <085f01cc8a40$df7af8a0$9e70e9e0$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Heiko St?bner wrote:
> 
> To enable cpu frequency scaling on the S3C2416/2450 it is necessary
> to define the arm-divider and armclock.
> 
> The layout of the clocks (i.e. msysclk -> armdiv -> armclk) is the
> same on all three architectures (S3C2443/2416/2450) and only the
> possible dividers for armdiv differ.
> Therefore it is possible to move the armdiv and armclk to common
> code with only the divider table definition remaining in the respective
> clock.c-files.
> The s3c2443_common_init_clocks method is modified to make it possible
> to transmit the divider table to the common code.
> 
> As the armdiv is available in common code now, the fdiv function
> pointer passed to s3c2443_common_init_clocks becomes obsolete and is
> therefore removed as the fclk rate can be set by a clk_get_rate call.
> 
> It works as expected on S3C2416, is compile-tested on S3C2443
> and checkpatch was happy.
> 
> 
> Heiko Stuebner (8):
>   S3C2416: Add armdiv_mask constant.
>   S3C2443: Add infrastructure to transmit armdiv to common code
>   S3C2443: Move clk_arm and clk_armdiv to common code.
>   S3C2416: Add comment describing the armdiv/armclk.
>   S3C2443: Add get_rate operation for clk_armdiv
>   S3C2443: handle unset armdiv values gracefully.
>   S3C2443: Accommodate cpufreq frequency scheme in armdiv
>   S3C2443: use clk_get_rate to init fclk in common_setup_clocks
> 
>  .../mach-s3c2410/include/mach/regs-s3c2443-clock.h |    1 +
>  arch/arm/mach-s3c2416/clock.c                      |   21 ++--
>  arch/arm/mach-s3c2443/clock.c                      |   98 +--------------
>  arch/arm/plat-s3c24xx/include/plat/s3c2443.h       |    7 +-
>  arch/arm/plat-s3c24xx/s3c2443-clock.c              |  134
> +++++++++++++++++++-
>  5 files changed, 152 insertions(+), 109 deletions(-)
> 
> --
> 1.7.5.4

Looks ok to me, applied.

As a note, if required, 1st patch which is fixing will be sent to stable.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
