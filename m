From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Fri, 4 Feb 2011 15:49:11 +0530
Subject: [PATCH 0/5] ARM: Few patches for PM enablement.
In-Reply-To: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
References: <1295859080-15259-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <f804b2179a222189b71c9429285de723@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,
> -----Original Message-----
> From: Santosh Shilimkar [mailto:santosh.shilimkar at ti.com]
> Sent: Monday, January 24, 2011 2:21 PM
> To: linux-arm-kernel at lists.infradead.org
> Cc: linux-omap at vger.kernel.org; ccross at android.com;
> catalin.marinas at arm.com; linux at arm.linux.org.uk;
> linus.ml.walleij at gmail.com; Santosh Shilimkar
> Subject: [PATCH 0/5] ARM: Few patches for PM enablement.
>
> The series consist of few patches to address some common PM issues
> on Cortex-A9 based ARM SoCs. The skip calibration on secondary cores
> is still under discussion.
> On OMAP, the GIC save restore is done differently and hence that
> part isn't included. Collin already have a patch for the same which
> should address other SOCs.
>
> The following changes since commit
> 1bae4ce27c9c90344f23c65ea6966c50ffeae2f5:
>   Linus Torvalds (1):
>         Linux 2.6.38-rc2
>
I want to repost this series with update as disussed on the
list.

>       ARM: gic: Add hooks for architecture specific extensions
I am adding set_type and ack as an additional hooks reuested
by Collin.

>       ARM: gic: Add distributor and interface enable/disable
> accessory api
No change

>       ARM: twd: Add context save restore support
Will drop this patch and add your patch instead.

>       ARM: scu: Move register defines to header file
Same for this too. Your version instead of this patch.

>       ARM: smp: Skip secondary cpu calibration to speed-up boot
Your last comment on this one was
"I still point out that this will be a user visible change in
/proc/cpuinfo."
Are you ok with this patch if platforms like OMAP are
ok with this visible change. This patch currently affecting
only OMAP.

Do you have any more points on this series ?

Thanks for review.

Regards,
Santosh
