From: shawn.guo@freescale.com (Shawn Guo)
Date: Wed, 21 Sep 2011 17:43:14 +0800
Subject: [PATCH 0/3] GIC OF bindings
In-Reply-To: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
References: <1316550244-3655-1-git-send-email-robherring2@gmail.com>
Message-ID: <20110921094313.GD28907@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 20, 2011 at 03:24:01PM -0500, Rob Herring wrote:
> From: Rob Herring <rob.herring@calxeda.com>
> 
> Hopefully, this is the final or near final version of GIC binding support.
> 
> Changes from the previous version:
> - SPIs and PPIs are numbered starting at 0. Now the gic has it's own irq
>   domain translate function instead of the simple domain one.
> - interrupt cell format has changed based on Grant's proposal.
> - Dropped "ARM: gic: allow irq_start to be 0". Instead, the first 16 irqs
>   are skipped and the domain irq_base adjusted accordingly.
> - Added a fix to of_irq_find_parent when the parent == child.
> - Renamed intc_desc.parent to intc_desc.interrupt_parent.
> - Implemented Grant's algorithm for walking the list of interrupt
>   controllers. Added a return value to interrupt init functions, so they
>   don't get added to the parent list on a init failure.
> 
> The changes are significant enough that I did not include previous
> acked/reviewed/tested-by's.
> 
You can add mine back.  On imx6q:

Tested-by: Shawn Guo <shawn.guo@linaro.org>

Hopefully, this is the last round of binding scheme change.  There are
63 nodes in imx6q dts with 'interrupts' property.  I have changed them
3 times :)

-- 
Regards,
Shawn
