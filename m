From: shawn.guo@linaro.org (Shawn Guo)
Date: Tue, 20 Mar 2012 16:13:33 +0800
Subject: [PATCH 2/2] clk: Move init fields from clk to clk_hw
In-Reply-To: <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
References: <CAJOA=zN2cSSpM92oRnW0RyU_ZzyoQ=jthc-fAkf-P3z37uWt7w@mail.gmail.com>
 <1332214706-675-1-git-send-email-skannan@codeaurora.org>
 <1332214706-675-2-git-send-email-skannan@codeaurora.org>
 <20120320072018.GC32469@S2101-09.ap.freescale.net>
 <cbd6490459b9fd68875fec4a7c7de073.squirrel@www.codeaurora.org>
Message-ID: <20120320081331.GD32469@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 20, 2012 at 12:54:55AM -0700, Saravana Kannan wrote:
> 
> On Tue, March 20, 2012 12:20 am, Shawn Guo wrote:
...
> > struct clk *clk_register_fixed_rate(struct device *dev, const char *name,
> >                 const char *parent_name, unsigned long flags,
> >                 unsigned long fixed_rate);
> > struct clk *clk_register_gate(struct device *dev, const char *name,
> >                 const char *parent_name, unsigned long flags,
> >                 void __iomem *reg, u8 bit_idx,
> >                 u8 clk_gate_flags, spinlock_t *lock);
> > struct clk *clk_register_divider(struct device *dev, const char *name,
> >                 const char *parent_name, unsigned long flags,
> >                 void __iomem *reg, u8 shift, u8 width,
> >                 u8 clk_divider_flags, spinlock_t *lock);
> > struct clk *clk_register_mux(struct device *dev, const char *name,
> >                 char **parent_names, u8 num_parents, unsigned long flags,
> >                 void __iomem *reg, u8 shift, u8 width,
> >                 u8 clk_mux_flags, spinlock_t *lock);
> 
> If you simplify those functions further. They would just become
> clk_register(). I'm not sure I see a value in them in at that point or
> even in their current form. But if others see (I'm guessing since they
> acked or didn't nack it), I'm not going to ask to remove them. If everyone
> agrees that we should just remove them, I would be glad to.
> 
> It's arguable that these functions for the common hardware types saves the
> need to deal with the kalloc in every platform driver. But it's not clear
> to me where they would get these parameters in the first place. Most
> likely form some sort of static array. At which point, it might as well be
> a static array of pointers to clk_gated.hw, clk_fixed_rate.hw, etc instead
> of a platform specific  struct to hold these initializers.

I share the save view on this, so would vote to remove these
registration functions for basic clks completely.

Regards,
Shawn
