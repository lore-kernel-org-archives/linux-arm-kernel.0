From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 17 Jan 2015 02:34:42 +0100
Subject: [PATCH] USB: host: ehci_atmel: Add suspend/resume support
In-Reply-To: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
References: <1421437274-31615-1-git-send-email-sylvain.rochet@finsecur.com>
Message-ID: <20150117013442.GV3843@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

You should probably put the susbsytem maintainers in copy too. As
reported by get_maintainer.pl:
Alan Stern <stern@rowland.harvard.edu> (maintainer:USB EHCI DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)

They will be the one taking the patch.

And when dealing with PM on AT91, please copy
Wenyou Yang <wenyou.yang@atmel.com>


On 16/01/2015 at 20:41:14 +0100, Sylvain Rochet wrote :
> This patch add suspend/resume support for Atmel EHCI, mostly
> about disabling and unpreparing clocks so USB PLL is stopped
> before entering sleep state.
> 
> Signed-off-by: Sylvain Rochet <sylvain.rochet@finsecur.com>

Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> +
> +	if (at91_suspend_entering_slow_clock())
> +		atmel_stop_clock();
> +

We should definitely find a way to get rid of
at91_suspend_entering_slow_clock() at some point in time.


-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
