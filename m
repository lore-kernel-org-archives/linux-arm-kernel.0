From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 6 Jun 2018 12:29:06 -0700
Subject: [PATCH v4 0/6] Enhance support for the SP805 WDT
In-Reply-To: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
References: <1527530497-10392-1-git-send-email-ray.jui@broadcom.com>
Message-ID: <e3f657f1-bd7e-cadb-9cfe-dee6cf8c1668@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/28/2018 11:01 AM, Ray Jui wrote:
> This patch series enhances the support for the SP805 watchdog timer.
> First of all, 'timeout-sec' devicetree property is added. In addition,
> support is also added to allow the driver to reset the watchdog if it
> has been detected that watchdot has been started in the bootloader. In
> this case, the driver will initiate the ping service from the kernel
> watchdog subsystem, before a user mode daemon takes over. This series
> also enables SP805 in the default ARM64 defconfig
> 
> This patch series is based off v4.17-rc5 and is available on GIHUB:
> repo: https://github.com/Broadcom/arm64-linux.git
> branch: sp805-wdt-v4
> 
> Changes since v3:
>  - Improve description of 'timeout-sec' in the binding document, per
> recommendation from Guenter Roeck
> 
> Changes since v2:
>  - Fix indent and format to make them consistent within arm,sp805.txt
> 
> Changes since v1:
>  - Consolidate two duplicated SP805 binding documents into one
>  - Slight change of the wdt_is_running implementation per discussion
> 
> Ray Jui (6):
>   Documentation: DT: Consolidate SP805 binding docs
>   Documentation: DT: Add optional 'timeout-sec' property for sp805
>   watchdog: sp805: add 'timeout-sec' DT property support
>   watchdog: sp805: set WDOG_HW_RUNNING when appropriate
>   arm64: dt: set initial SR watchdog timeout to 60 seconds
>   arm64: defconfig: add CONFIG_ARM_SP805_WATCHDOG

I can take the last two patches and Guenter would take the first 4 or
would you want to proceed differently?
-- 
Florian
