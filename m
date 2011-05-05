From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Thu, 5 May 2011 23:48:28 +0530
Subject: Tegra gpio driver: Need to configure pins in gpio
	mode/nontristate with gpio-request
In-Reply-To: <BANLkTikFgc2Oe5BrOpzYkjs7wnMdfNY4_w@mail.gmail.com>
References: <96C9D994977DD0439FB6D3FE3B13DD906B1331B068@BGMAIL01.nvidia.com>
	<BANLkTikFgc2Oe5BrOpzYkjs7wnMdfNY4_w@mail.gmail.com>
Message-ID: <96C9D994977DD0439FB6D3FE3B13DD906B1331B0BD@BGMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Then from user space using /sys/class/gpio sysfs interface, I can not make the pin to be gpio until I change the kernel code?


-----Original Message-----
From: Colin Cross [mailto:ccross at google.com] 
Sent: Thursday, May 05, 2011 10:19 PM
To: Laxman Dewangan
Cc: linux-tegra at vger.kernel.org; linux-arm-kernel at lists.infradead.org
Subject: Re: Tegra gpio driver: Need to configure pins in gpio mode/nontristate with gpio-request

On Thu, May 5, 2011 at 3:16 AM, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> Hi All,
> When working on gpio driver for tegra, I found that gpio_request() does not
> make the corresponding soc pins to gpio mode. It still keeps the pins in SFIO mode.
> So we need to call two extra function along with gpio_request():
> Tegra_gpio_enable() and function for setting the pins in no non-tristate.
>
> Sue to this, the gpio sysfs interface does not work properly from user space /sys/class/gpio/.
> To make the pin in gpio mode fom user space, need to have changes in kernel.
>
> I think the gpio_request() should make the pins to gpio mode and make ready for use.
> Similarly gpio_free() should again put the pin into sfio mode with tristate disable.
>
> Please comment if there is any better way..
