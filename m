From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 06 Sep 2012 20:17:21 -0700
Subject: [PATCHv2 2/2] msm: io: Change the default static iomappings to
 be shared
In-Reply-To: <1346951799-9415-1-git-send-email-rvaswani@codeaurora.org>
References: <CAOesGMgC2OxEs-wGRQku-GeoiaO2Wa_dZ2AuwnKd3Nze4gknqQ@mail.gmail.com>
 <1346951799-9415-1-git-send-email-rvaswani@codeaurora.org>
Message-ID: <50496741.8000305@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/06/12 10:16, Rohit Vaswani wrote:
>  static struct map_desc msm_io_desc[] __initdata = {
> -	MSM_DEVICE(VIC),
> -	MSM_CHIP_DEVICE(CSR, MSM7X00),
> -	MSM_DEVICE(DMOV),
> -	MSM_CHIP_DEVICE(GPIO1, MSM7X00),
> -	MSM_CHIP_DEVICE(GPIO2, MSM7X00),
> -	MSM_DEVICE(CLK_CTL),
> +	MSM_DEVICE_TYPE(VIC, MT_DEVICE_NONSHARED),
> +	MSM_CHIP_DEVICE_TYPE(CSR, MSM7X00, MT_DEVICE_NONSHARED),
> +	MSM_DEVICE_TYPE(DMOV, MT_DEVICE_NONSHARED),
> +	MSM_CHIP_DEVICE_TYPE(GPIO1, MSM7X00, MT_DEVICE_NONSHARED),
> +	MSM_CHIP_DEVICE_TYPE(GPIO2, MSM7X00, MT_DEVICE_NONSHARED),
> +	MSM_CHIP_DEVICE_TYPE(CLK_CTL, MSM7X00, MT_DEVICE_NONSHARED),

This one is supposed to be MSM_DEVICE_TYPE.

Please squash this in:

diff --git a/arch/arm/mach-msm/io.c b/arch/arm/mach-msm/io.c
index 35d6926..d908a37 100644
--- a/arch/arm/mach-msm/io.c
+++ b/arch/arm/mach-msm/io.c
@@ -52,7 +52,7 @@ static struct map_desc msm_io_desc[] __initdata = {
        MSM_DEVICE_TYPE(DMOV, MT_DEVICE_NONSHARED),
        MSM_CHIP_DEVICE_TYPE(GPIO1, MSM7X00, MT_DEVICE_NONSHARED),
        MSM_CHIP_DEVICE_TYPE(GPIO2, MSM7X00, MT_DEVICE_NONSHARED),
-       MSM_CHIP_DEVICE_TYPE(CLK_CTL, MSM7X00, MT_DEVICE_NONSHARED),
+       MSM_DEVICE_TYPE(CLK_CTL, MT_DEVICE_NONSHARED),
 #if defined(CONFIG_DEBUG_MSM_UART1) || defined(CONFIG_DEBUG_MSM_UART2) || \
        defined(CONFIG_DEBUG_MSM_UART3)
        MSM_DEVICE_TYPE(DEBUG_UART, MT_DEVICE_NONSHARED),

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
