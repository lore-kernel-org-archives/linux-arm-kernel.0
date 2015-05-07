From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 7 May 2015 20:13:24 +0100
Subject: [STLinux Kernel] [PATCH 02/12] clocksource: sti: Provide support
 for the ST LPC Clocksource IP
In-Reply-To: <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
 <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
Message-ID: <20150507191324.GB16220@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > This IP is shared with Watchdog and RTC functionality.  Only one of
> > these IPs can be used at the same time.  We use the device-driver
> > model combined with a DT 'mode' property to enforce this.
> 
> Which means my previous assertion in V1 that the IP didn't exist on stih415/6
> SoC is most likely wrong, as the watchdog driver has bindings already for those
> platforms.
> 
> I did try this before and couldn't get it working (driver failed on clk_get_rate)
> on stih416-b2020.
> 
> Did you try and see if you can get this also working for stih415/6 SoCs? It would
> mean we can move away from arm_global_timer for all upstreamed STI platforms.

This patch-set only supports STiH4{07,10}, which is the only platform
it's been tested on until this point.  I can investigate porting it to
Orly/Orly2 as a subsequent piece of work if it's going to be useful
for ST.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
