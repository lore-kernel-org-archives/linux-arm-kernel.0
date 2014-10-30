From: thierry.reding@gmail.com (Thierry Reding)
Date: Thu, 30 Oct 2014 15:57:46 +0100
Subject: [PATCH v3 01/12] clk: tegra: Implement memory-controller clock
In-Reply-To: <CAAObsKB0ozbOy8ZzgbEyf-SrqF5jpfHUXCJdAMiqgS78DAyaVA@mail.gmail.com>
References: <1413196434-5292-1-git-send-email-thierry.reding@gmail.com>
 <CAAObsKB0ozbOy8ZzgbEyf-SrqF5jpfHUXCJdAMiqgS78DAyaVA@mail.gmail.com>
Message-ID: <20141030145744.GE20072@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 20, 2014 at 01:02:45PM +0200, Tomeu Vizoso wrote:
> On 13 October 2014 12:33, Thierry Reding <thierry.reding@gmail.com> wrote:
[...]
> > +struct clk *tegra_clk_register_mc(const char *name, const char *parent_name,
> > +                                 void __iomem *reg, spinlock_t *lock)
> > +{
> > +       return clk_register_divider_table(NULL, "mc", "emc_mux", 0, reg,
> 
> Should take name and parent_name from the passed args?
> 
> With that change:
> 
> Reviewed-By: Tomeu Vizoso <tomeu.vizoso@collabora.com>

Good catch.

Thanks,
Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141030/89e7ccae/attachment.sig>
