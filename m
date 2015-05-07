From: peter.griffin@linaro.org (Peter Griffin)
Date: Thu, 7 May 2015 16:04:40 +0100
Subject: [STLinux Kernel] [PATCH 02/12] clocksource: sti: Provide support
 for the ST LPC Clocksource IP
In-Reply-To: <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
References: <1431005924-21777-1-git-send-email-lee.jones@linaro.org>
 <1431005924-21777-3-git-send-email-lee.jones@linaro.org>
Message-ID: <20150507150440.GA13336@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Thu, 07 May 2015, Lee Jones wrote:

> This IP is shared with Watchdog and RTC functionality.  Only one of
> these IPs can be used at the same time.  We use the device-driver
> model combined with a DT 'mode' property to enforce this.

Which means my previous assertion in V1 that the IP didn't exist on stih415/6
SoC is most likely wrong, as the watchdog driver has bindings already for those
platforms.

I did try this before and couldn't get it working (driver failed on clk_get_rate)
on stih416-b2020.

Did you try and see if you can get this also working for stih415/6 SoCs? It would
mean we can move away from arm_global_timer for all upstreamed STI platforms.

regards,

Peter.
