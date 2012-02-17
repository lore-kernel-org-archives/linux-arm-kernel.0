From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 17 Feb 2012 10:47:58 +0000
Subject: SMP local timers and their CPUfreq notifiers setup on OMAP3
In-Reply-To: <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
References: <8739aahc0n.fsf@ti.com> <4F3E0655.2040702@ti.com>
 <0401fed02a58f7bc48cc274050adbac7@localhost>
 <CAMQu2gwW6ES14jB8E6snE4pQRKg1q2ZF0pBedBtuPxeYV+7cow@mail.gmail.com>
Message-ID: <20120217104758.GO15338@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 17, 2012 at 04:10:57PM +0530, Shilimkar, Santosh wrote:
> -	if (!IS_ERR(twd_clk))
> +	if ((!twd_evt) && (!__this_cpu_ptr(twd_evt)) && (!IS_ERR(twd_clk)))

Too many parens.
