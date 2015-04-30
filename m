From: r.schwebel@pengutronix.de (Robert Schwebel)
Date: Thu, 30 Apr 2015 19:55:41 +0200
Subject: [PATCH 2/2] ARM: vexpress: Add interrupt-affinity
In-Reply-To: <1430416448-25203-1-git-send-email-r.schwebel@pengutronix.de>
References: <1430416448-25203-1-git-send-email-r.schwebel@pengutronix.de>
Message-ID: <20150430175541.GL15254@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 30, 2015 at 07:54:08PM +0200, Robert Schwebel wrote:
> Without this property, we get this boot warning:
> 
> [    0.459361] CPU PMU: Failed to parse <no-node>/interrupt-affinity[0]
> 
> Signed-off-by: Robert Schwebel <r.schwebel@pengutronix.de>

However, with this patch applied, the messages above disappear, but I
still get this:

[    0.495280] CPU PMU: Failed to find logical CPU for cpu

on a kernel configured with CONFIG_SMP=n. nr_cpu_ids is 1 there, while 
the loop still loops over all available cores. Ths makes the logic fail.

rsc
-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
