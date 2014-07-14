From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 14 Jul 2014 10:31:25 -0400
Subject: [PATCH v2] ARM: OMAP2+: l2c: squelch warning dump on power control
 setting
In-Reply-To: <d081bdbeebec0e7f2a292a11513f96375aa35bd4.1405343188.git.nsekhar@ti.com>
References: <d081bdbeebec0e7f2a292a11513f96375aa35bd4.1405343188.git.nsekhar@ti.com>
Message-ID: <53C3E9BD.9010104@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 14 July 2014 09:13 AM, Sekhar Nori wrote:
> On OMAP SOCs using PL310 controllers, power_ctrl register is not
> accessible from non-secure software even on PL310 versions which
> support it. The secure code takes care of setting it up correctly
> and power transitions are proven on these devices.
> 
> For example, AM437x has L2C-310 version r3p3 and ROM code on that
> device does not support writing to L2C-310 power control register.
> The L2C driver, however, tries writing to this register for all
> revisions >= r3p0.
> 
> This leads to a warning dump on boot which leads most users to believe
> that L2 cache is non-functional.
> 
> Since the problem is understood, and cannot be addressed through
> software, replace the warning with a pr_info() while maintaining the
> WARN_ON() for other truly unexpected scenarios.
> 
> Reported-by: Nishanth Menon <nm@ti.com>
> Tested-by: Felipe Balbi <balbi@ti.com>
> Signed-off-by: Sekhar Nori <nsekhar@ti.com>
> ---
> Only description updated since v1
> 
Thanks for update.
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
