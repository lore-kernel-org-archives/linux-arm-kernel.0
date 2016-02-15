From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 Feb 2016 20:47:40 +0100
Subject: [PATCH] drivers: power: reset: at91-reset: Provide reset reason
 via sysfs (amended with Signed-off-by tag)
In-Reply-To: <20160127071418.GA7124@earth>
References: <1453394936-16616-1-git-send-email-davidm@egauge.net>
 <20160125085539.GB16261@piout.net> <20160127071418.GA7124@earth>
Message-ID: <20160215194740.GD15219@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/01/2016 at 08:14:21 +0100, Sebastian Reichel wrote :
> I can see, that there are currently six different values possible
> for at91-reset, but it's unclear to me what some of them mean, so
> that should be covered in the ABI documentation. Also it may make
> sense to drop the reset suffix for some of them (e.g. "unknown").
> 
>     reason = "general reset";
> 
>     This is power-on by power-button/applying voltage?
> 

Yes

>     reason = "wakeup";
> 
>     This is power-on by RTC?
> 

This can actually be any wakeup, but most likely RTC but it could also
be triggered by an external PMIC. Atmel's definition is general: both
VDDcore and VDDbu are rising, wakeup: only VDDcore is rising

>     reason = "watchdog reset";
> 
>     I gues this is reboot triggered by watchdog timeout?
> 

Yes

>     reason = "software reset";
> 
>     This will be returned if system was started by rebooting via
>     "reboot / shutdown -r"?
> 

This will be the case yes

>     reason = "user reset";
> 
>     This is returned if the board's reset button was pressed?
> 

Reset button or any signal on the reset pin of the SoC


>     reason = "unknown reset";
> 
>     => just use "unknown"
> 

It should not happen anyway :)

> I suggest to create include/linux/power/power_on_reason.h, with
> standardized values, that are used by the driver:
> 
> #define POWER_ON_REASON_RTC "RTC wakeup"
> #define POWER_ON_REASON_WATCHDOG "watchdog timeout"
> ...
> 


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
