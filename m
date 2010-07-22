From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Jul 2010 08:55:05 +0100
Subject: [PATCH]HRT support in Samsung S5P Platform
In-Reply-To: <13968563.679171279522453031.JavaMail.weblogic@epml17>
References: <13968563.679171279522453031.JavaMail.weblogic@epml17>
Message-ID: <20100722075505.GE6802@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 19, 2010 at 06:54:13AM +0000, MADHAV SINGHCHAUHAN wrote:
> +config MACH_S5PV210_HRT
> +        bool "HRtimer and Dynamic Tick support"
> +        select GENERIC_TIME
> +        select GENERIC_CLOCKEVENTS
> +        select HIGH_RES_TIMERS
> +        default n

Please avoid 'default n'.

> +static unsigned int sched_timer_running;
> +
> +void __iomem *rtc_base =	S3C_VA_RTC;

static?
