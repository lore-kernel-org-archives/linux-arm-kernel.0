From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jan 2017 10:11:10 -0800
Subject: [PATCH] ARM: OMAP5: Add HWMOD_SWSUP_SIDLE_ACT flag for UART
In-Reply-To: <e84cd7c8-89bc-b2ef-e57d-6c0a37b0b51e@ti.com>
References: <20170118114807.9543-1-vigneshr@ti.com>
 <e84cd7c8-89bc-b2ef-e57d-6c0a37b0b51e@ti.com>
Message-ID: <20170120181110.GB7403@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Lokesh Vutla <lokeshvutla@ti.com> [170119 01:08]:
> 
> 
> On Wednesday 18 January 2017 05:18 PM, Vignesh R wrote:
> > According to the commit ca43ea345de9 ("ARM: OMAP2+: hwmod: Add a new
> > flag to handle SIDLE in SWSUP only in active"), UART IP needs the sidle
> > mode to be controlled in SW only while they are active. Once inactive,
> > the IP needs to be put back in HW control so they are also wakeup
> > capable. The flag HWMOD_SWSUP_SIDLE takes care of this. So add this flag
> > to all instances of UART.
> > 
> > With this change, 8250 UART now gives out proper RX Timeout interrupts
> > and is usable as console.
> > 
> > Signed-off-by: Vignesh R <vigneshr@ti.com>
> 
> Reviewed-by: Lokesh Vutla <lokeshvutla@ti.com>

Thanks yeah this fixes the issue. As this is not a regression fix, applying
into omapf-rov-4.11/fixes-not-urgent.

Regards,

Tony
