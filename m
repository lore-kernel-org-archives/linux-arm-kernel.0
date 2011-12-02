From: nsekhar@ti.com (Nori, Sekhar)
Date: Fri, 2 Dec 2011 15:57:57 +0000
Subject: [PATCH] ARM: mach-davinci: fixed name and parent of pll1 sysclock6
In-Reply-To: <20111104110004.GA15331@altenpts-laptop>
References: <20111104110004.GA15331@altenpts-laptop>
Message-ID: <DF0F476B391FA8409C78302C7BA518B6039BBA@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 04, 2011 at 16:30:07, Bas van den Berg wrote:
> The name and parent of pll1_sysclk6 should be pll1 and not pll0.
> Checked and tested in debugfs on OmapL138.
> 
> Signed-off-by: Bas van den Berg <b.van.den.berg.nl@gmail.com>
> ---

Thanks for spotting this. Looking at the technical
reference manual[1], there is a bigger issue here.

PLL1 SYSCLK6 doesn't exist in hardware! Only PLL1_SYSCLK[1-3]
are valid. The right fix would be simply to remove these
erroneous entries.

Would be able to respin the patch?

Thanks,
Sekhar

[1] http://www.ti.com/lit/ug/spruh77a/spruh77a.pdf
