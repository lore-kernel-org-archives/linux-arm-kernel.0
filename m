From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 19 Jan 2012 11:39:40 +0000
Subject: [V3 0/6] rtc-sa1100 clean up
In-Reply-To: <1322634843-4733-1-git-send-email-jtzhou@marvell.com>
References: <1322634843-4733-1-git-send-email-jtzhou@marvell.com>
Message-ID: <20120119113940.GV1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 30, 2011 at 02:34:03PM +0800, Jett.Zhou wrote:
> This patch set do the following things:
>   1) clean up sa1100-rtc for support sa1100/pxa/mmp series
>   2) add dummy clock for pxa arch
>   3) clean up clock dev for sa1100 arch and add dummy clock for sa1100
>   4) fix build error for sa1100 arch

Guys,

If you're modifying a driver which is shared across different architectures
please try to build it for those different architectures.  It helps to
avoid receiving reports like the below:

drivers/rtc/rtc-sa1100.c:42:1: warning: "RCNR" redefined
In file included from arch/arm/mach-sa1100/include/mach/hardware.h:73,
                 from drivers/rtc/rtc-sa1100.c:35:
arch/arm/mach-sa1100/include/mach/SA-1100.h:877:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:43:1: warning: "RTAR" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:876:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:44:1: warning: "RTSR" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:879:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:45:1: warning: "RTTR" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:878:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:47:1: warning: "RTSR_HZE" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:891:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:48:1: warning: "RTSR_ALE" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:890:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:49:1: warning: "RTSR_HZ" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:889:1: warning: this is the location of the previous definition
drivers/rtc/rtc-sa1100.c:50:1: warning: "RTSR_AL" redefined
arch/arm/mach-sa1100/include/mach/SA-1100.h:888:1: warning: this is the location of the previous definition

Please fix it.
