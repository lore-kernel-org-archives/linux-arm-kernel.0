From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 12 Jan 2012 09:16:43 +0000
Subject: [PATCH 09/15] ARM: ux500: convert to
 twd_local_timer_register() interface
In-Reply-To: <1326287334-1905-10-git-send-email-marc.zyngier@arm.com>
References: <1326287334-1905-1-git-send-email-marc.zyngier@arm.com>
 <1326287334-1905-10-git-send-email-marc.zyngier@arm.com>
Message-ID: <20120112091643.GI1068@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 11, 2012 at 01:08:48PM +0000, Marc Zyngier wrote:
> +static void __init ux500_twd_set_base(unsigned long base)
> +{
> +	twd_local_timer.res[0].start = base;
> +	twd_local_timer.res[0].end = base + 0x10;

Does this local timer really occupy 0x11 bytes?
