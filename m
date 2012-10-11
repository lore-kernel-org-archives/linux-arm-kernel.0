From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 11 Oct 2012 17:55:06 +0530
Subject: [PATCH v2 09/13] ARM: davinci - update the dm644x soc code to
 use common clk drivers
In-Reply-To: <1348683037-9705-10-git-send-email-m-karicheri2@ti.com>
References: <1348683037-9705-1-git-send-email-m-karicheri2@ti.com>
 <1348683037-9705-10-git-send-email-m-karicheri2@ti.com>
Message-ID: <5076BAA2.6010404@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Murali,

On 9/26/2012 11:40 PM, Murali Karicheri wrote:
> The clock tree for dm644x is defined using the new structure davinci_clk.
> The SoC specific code re-uses clk-fixed-rate, clk-divider and clk-mux
> drivers in addition to the davinci specific clk drivers, clk-davinci-pll
> and clk-davinci-psc. Macros are defined to define the various clocks in
> the SoC.
> 
> Signed-off-by: Murali Karicheri <m-karicheri2@ti.com>

You have chosen to keep all clock related data in platform files while
using the common clock framework to provide just the infrastructure. If
you look at how mxs and spear have been migrated, they have migrated the
soc specific clock data to drivers/clk as well. See
"drivers/clk/spear/spear3xx_clock.c" or "drivers/clk/mxs/clk-imx23.c". I
feel the latter way is better and I also think it will simplify some of
the look-up infrastructure you had to build. This will also help some
real code reduction from arch/arm/mach-davinci/.

Thanks,
Sekhar
