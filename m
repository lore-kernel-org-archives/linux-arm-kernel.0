From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 02 May 2013 10:35:19 +0200
Subject: [PATCH] mxs: icoll: Add function to register an interrupt as
 FIQ source
In-Reply-To: <20130502023858.GD3442@S2101-09.ap.freescale.net>
References: <1367243917-5177-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130502023858.GD3442@S2101-09.ap.freescale.net>
Message-ID: <51822547.20605@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

Le 02/05/2013 04:39, Shawn Guo a ?crit :
> On Mon, Apr 29, 2013 at 03:58:37PM +0200, Maxime Ripard wrote:
>> MXS, unlike other ARM platforms,
> 
> How are other ARM platforms handling that?

Just like that. You can look at mxc_set_irq_fiq in
arch/arm/mach-imx/irq-common.c or s3c24xx_set_fiq in
arch/arm/mach-s3c24xx/irq.c

I've also thought about declaring a IRQ type and using the .irq_set_type
to register an interrupt as a FIQ source, but since FIQ are
ARM-specific, it's probably a bad idea.

>> has no way to make a FIQ from an
>> interrupt from a driver, without poking directly into the icoll.
>>
>> Add an exported function to do this.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>> ---
>>  arch/arm/mach-mxs/icoll.c | 11 +++++++++++
> 
> This will become drivers/irqchip/irq-mxs.c after the merge window.

Ok, I'll rebase and repost then.

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
