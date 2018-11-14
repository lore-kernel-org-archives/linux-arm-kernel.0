From: will.deacon@arm.com (Will Deacon)
Date: Wed, 14 Nov 2018 21:51:13 +0000
Subject: [PATCH v4 1/4] kgdb: Remove irq flags from roundup
In-Reply-To: <20181112182659.245726-2-dianders@chromium.org>
References: <20181112182659.245726-1-dianders@chromium.org>
 <20181112182659.245726-2-dianders@chromium.org>
Message-ID: <20181114215112.GA4044@brain-police>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 12, 2018 at 10:26:55AM -0800, Douglas Anderson wrote:
> The function kgdb_roundup_cpus() was passed a parameter that was
> documented as:
> 
> > the flags that will be used when restoring the interrupts. There is
> > local_irq_save() call before kgdb_roundup_cpus().
> 
> Nobody used those flags.  Anyone who wanted to temporarily turn on
> interrupts just did local_irq_enable() and local_irq_disable() without
> looking at them.  So we can definitely remove the flags.
> 
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---

Acked-by: Will Deacon <will.deacon@arm.com>

I'm hopeful that you'll keep hacking on kgdb, because it definitely needs
some love in its current state.

Will
