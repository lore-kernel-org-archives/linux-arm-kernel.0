From: tony@atomide.com (Tony Lindgren)
Date: Wed, 2 Mar 2011 10:24:02 -0800
Subject: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be
	configured from board file
In-Reply-To: <AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-7-git-send-email-govindraj.raja@ti.com>
	<056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
	<AANLkTimD9rOC=4P6Vy2jzvcXZ-gZmF42Te4CBjS8AJLT@mail.gmail.com>
	<8ab9882cd92792e9bf2b836c0ec9c7fe@mail.gmail.com>
	<AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
Message-ID: <20110302182402.GC20560@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Govindraj <govindraj.ti@gmail.com> [110302 02:05]:
>
> >>>>+static struct omap_device_pad default_serial1_pads[] __initdata = {
> >>>>+ ? ? ?{
> >>>>+ ? ? ? ? ? ? ?.name ? = "uart2_rx.uart2_rx",
> >>>>+ ? ? ? ? ? ? ?.flags ?= OMAP_DEVICE_PAD_REMUX |
> > OMAP_DEVICE_PAD_WAKEUP,
> >>>>+ ? ? ? ? ? ? ?.enable = OMAP_MUX_MODE0,
> >>>>+ ? ? ?},
...

AFAIK you should only need the OMAP_DEVICE_PAD_REMUX option for
omap24xx. And if you use that option, you also need the .idle
value.

Tony
