From: will.deacon@arm.com (Will Deacon)
Date: Thu, 4 Dec 2014 09:58:06 +0000
Subject: [PATCH] arm64: Provide a namespace to NCAPS
In-Reply-To: <1417655821-22892-1-git-send-email-festevam@gmail.com>
References: <1417655821-22892-1-git-send-email-festevam@gmail.com>
Message-ID: <20141204095806.GD13224@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 04, 2014 at 01:17:01AM +0000, Fabio Estevam wrote:
> From: Fabio Estevam <fabio.estevam@freescale.com>
> 
> Building arm64.allmodconfig leads to the following warning:
> 
> usb/gadget/function/f_ncm.c:203:0: warning: "NCAPS" redefined
>  #define NCAPS (USB_CDC_NCM_NCAP_ETH_FILTER | USB_CDC_NCM_NCAP_CRC_MODE)
>  ^
> In file included from /home/build/work/batch/arch/arm64/include/asm/io.h:32:0,
>                  from /home/build/work/batch/include/linux/clocksource.h:19,
>                  from /home/build/work/batch/include/clocksource/arm_arch_timer.h:19,
>                  from /home/build/work/batch/arch/arm64/include/asm/arch_timer.h:27,
>                  from /home/build/work/batch/arch/arm64/include/asm/timex.h:19,
>                  from /home/build/work/batch/include/linux/timex.h:65,
>                  from /home/build/work/batch/include/linux/sched.h:19,
>                  from /home/build/work/batch/arch/arm64/include/asm/compat.h:25,
>                  from /home/build/work/batch/arch/arm64/include/asm/stat.h:23,
>                  from /home/build/work/batch/include/linux/stat.h:5,
>                  from /home/build/work/batch/include/linux/module.h:10,
>                  from /home/build/work/batch/drivers/usb/gadget/function/f_ncm.c:19:
> arch/arm64/include/asm/cpufeature.h:27:0: note: this is the location of the previous definition
>  #define NCAPS     2
> 
> So add a ARM64 prefix to avoid such problem.

Thanks, applied.

Will
