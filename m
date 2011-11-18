From: khilman@ti.com (Kevin Hilman)
Date: Fri, 18 Nov 2011 13:24:38 -0800
Subject: [PATCH v8 17/20] OMAP2+: UART: Use custom activate func for
 console uart.
In-Reply-To: <1321005712-21871-3-git-send-email-govindraj.raja@ti.com>
 (Govindraj R.'s message of "Fri, 11 Nov 2011 15:31:50 +0530")
References: <1321005712-21871-1-git-send-email-govindraj.raja@ti.com>
 <1321005712-21871-3-git-send-email-govindraj.raja@ti.com>
Message-ID: <87vcqhuns9.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

"Govindraj.R" <govindraj.raja@ti.com> writes:

> Omap-uart can be used as console uart to print early boot
> messages using earlyprintk so for console uart prevent
> hwmod reset or idling during bootup.
>
> Identify the console_uart set the id and use the custom
> pm_latency ops for console uart for the first time
> to idle console uart left enabled from bootup and then enable
> them back and reset pm_latency ops to default ops.
>
> Thanks to Kevin Hilman <khilman@ti.com> for suggesting
> this approach.

You're welcome, but Rajendra's solution is much better. ;)

Can you updated your branch without these custom hooks and using
Rajendra's INIT_NO_IDLE change to the hwmod core.

Kevin
