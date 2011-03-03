From: govindraj.ti@gmail.com (Govindraj)
Date: Thu, 3 Mar 2011 17:44:38 +0530
Subject: [PATCH 6/7] OMAP: Serial: Allow UART parameters to be configured
	from board file
In-Reply-To: <20110302182402.GC20560@atomide.com>
References: <1298903958-6496-1-git-send-email-govindraj.raja@ti.com>
	<1298903958-6496-7-git-send-email-govindraj.raja@ti.com>
	<056ac5e848953fa5c37f7ed7a8cc1050@mail.gmail.com>
	<AANLkTimD9rOC=4P6Vy2jzvcXZ-gZmF42Te4CBjS8AJLT@mail.gmail.com>
	<8ab9882cd92792e9bf2b836c0ec9c7fe@mail.gmail.com>
	<AANLkTi=MJigLvbJrRJ4CpyDcGd8sZXB7-1nFYup6EeDm@mail.gmail.com>
	<20110302182402.GC20560@atomide.com>
Message-ID: <AANLkTim2+2cEEZrkF4eD2oNtv-ESLhTNVNO96TXHUm+-@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 2, 2011 at 11:54 PM, Tony Lindgren <tony@atomide.com> wrote:
> * Govindraj <govindraj.ti@gmail.com> [110302 02:05]:
>>
>> >>>>+static struct omap_device_pad default_serial1_pads[] __initdata = {
>> >>>>+ ? ? ?{
>> >>>>+ ? ? ? ? ? ? ?.name ? = "uart2_rx.uart2_rx",
>> >>>>+ ? ? ? ? ? ? ?.flags ?= OMAP_DEVICE_PAD_REMUX |
>> > OMAP_DEVICE_PAD_WAKEUP,
>> >>>>+ ? ? ? ? ? ? ?.enable = OMAP_MUX_MODE0,
>> >>>>+ ? ? ?},
> ...
>
> AFAIK you should only need the OMAP_DEVICE_PAD_REMUX option for
> omap24xx. And if you use that option, you also need the .idle
> value.
>

Yes correct. I should avoid enabling rx-pad wakeup for omap24xx and
populate rx pad wakeup only for 3xxx onwards as done prior to this patch.

Will correct this in next version.

--
Thanks,
Govindraj.R



> Tony
>
