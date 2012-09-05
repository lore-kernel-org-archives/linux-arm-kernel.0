From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 5 Sep 2012 08:51:36 +0800
Subject: [PATCH] kernel/sys.c: call disable_nonboot_cpus in kernel_restart
In-Reply-To: <20120904153624.d4aaed4e.akpm@linux-foundation.org>
References: <1346682298-13958-1-git-send-email-shawn.guo@linaro.org>
 <20120904153624.d4aaed4e.akpm@linux-foundation.org>
Message-ID: <20120905005134.GM2362@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 04, 2012 at 03:36:24PM -0700, Andrew Morton wrote:
> On Mon,  3 Sep 2012 22:24:58 +0800
> Shawn Guo <shawn.guo@linaro.org> wrote:
> 
> > Like kernel_power_off calls disable_nonboot_cpus, we may want to have
> > kernel_restart call disable_nonboot_cpus as well.  Doing so can help
> > the machines that require boot cpu be the last alive cpu during reboot
> > to survive with kernel restart.
> 
> That does sound logical.  But the changelog is very vague and fluffy. 
> Does this patch actually fix any known problem on any known machine?
> 
Yes, it fixes one reboot issue seen on imx6q (Cortex-A9 Quad).  The
machine requires the restart routine run on primary cpu than secondary
ones.  Otherwise, the secondary core running restart routine will fail
to come to online after reboot.

-- 
Regards,
Shawn
