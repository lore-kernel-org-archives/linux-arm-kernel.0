From: zumeng.chen@windriver.com (Zumeng Chen)
Date: Tue, 10 Jul 2012 12:17:40 +0800
Subject: [PATCH v2 RESEND 0/3] Watchdog: OMAP: bootstatus fix for omap3
 and changes for the current watchdog framework
In-Reply-To: <1341819328-3514-1-git-send-email-zumeng.chen@windriver.com>
References: <1341819328-3514-1-git-send-email-zumeng.chen@windriver.com>
Message-ID: <4FFBACE4.80901@windriver.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

? 2012?07?09? 15:35, Zumeng Chen ??:
> Hello,
>
> The following patches based on the 3.5-rc6 from Wim, which
> focus on:
>
> 1 ) bootstatus fix for omap3,
>
> 2 ) omap-wdt framework update cater for the current framework
>     as Shubhrajyoti comments mentioned.

I compiled a test case from the following website,
http://www.lpclinux.com/Blogs/Testing_LPC313x_Linux_Watchdog_Driver

It works well.

root at ti-omap3:/tmp# ./a.out -h
Usage: ./a.out [options]
-h --help Display this usage information.
-d --dev <device_file> Use <device_file> as watchdog device file.
The default device file is '/dev/watchdog'
-i --interval <interval> Change the watchdog interval time
root at ti-omap3:/tmp# ./a.out -i 40;
Set watchdog interval to 40
Current watchdog interval is 40
Last boot is caused by : Watchdog
Use:
<w> to kick through writing over device file
<i> to kick through IOCTL
<x> to exit the program
x
Goodbye !
watchdog: Omap Watchdog: nowayout prevents watchdog to be stopped!
watchdog: Omap Watchdog: watchdog did not stop!
root at ti-omap3:/tmp# for i in `seq 1 30`; do echo $i; sleep 1;done
1
2

[snip]

I built NOWAYOUT in driver, so it doesn't stop, still going until the
following
information:

Texas Instruments X-Loader 1.42
Starting OS Bootloader...
No OOB scheme defined for oobsize 0
OneNAND: 0 kB
256 MiB

Regards,
Zumeng
>
> Regards,
>
> Zumeng Chen (3):
>   Watchdog: Omap: Changes for the new watchdog framework
>   Watchdog: Omap: select watchdog core for framework change
>   Watchdog: Omap: get the bootstatus for OMAP2Plus
>
>  arch/arm/mach-omap2/prcm.c  |    5 +-
>  drivers/watchdog/Kconfig    |    1 +
>  drivers/watchdog/omap_wdt.c |  342 ++++++++++++++++---------------------------
>  drivers/watchdog/omap_wdt.h |    5 +
>  4 files changed, 133 insertions(+), 220 deletions(-)
>
