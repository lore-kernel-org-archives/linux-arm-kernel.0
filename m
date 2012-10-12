From: shubhrajyoti@ti.com (Shubhrajyoti)
Date: Fri, 12 Oct 2012 20:29:14 +0530
Subject: [PATCH 1/3] i2c: omap: Do not enable the irq always
In-Reply-To: <87lifb7odc.fsf@deeprootsystems.com>
References: <1349687116-14463-1-git-send-email-shubhrajyoti@ti.com>
 <87lifb7odc.fsf@deeprootsystems.com>
Message-ID: <50783042.2040609@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 12 October 2012 08:01 PM, Kevin Hilman wrote:
> When using runtime PM with auto-suspend timeouts, why would you disable
> the IRQ before the runtime suspend handlers have run?   
>
> If you really want to do this, you probably should have these in the
> runtime PM callbacks.  But I'll wait until you add a more descriptive
> changelog before I can really tell why this is being done.  Based on the
> discussion in the patch from Kalle, I'm assuming this is to prevent
> interrups when I2C is being used by co-processors.  If so, plese
> describe in the changelog.
>
> That being said, doesn't the runtime suspend callback already disable
> IRQs at the device level instead of the INTC level?
I thought of not relying on the intc as the registers may be reconfigured.
> Kevin
