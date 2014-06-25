From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jun 2014 22:14:16 +0200
Subject: [PATCH v3 0/6] clk: sunxi: fixes, cleanups and A23 basic clocks
In-Reply-To: <1403603980-31101-1-git-send-email-wens@csie.org>
References: <1403603980-31101-1-git-send-email-wens@csie.org>
Message-ID: <20140625201416.GH19569@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 05:59:34PM +0800, Chen-Yu Tsai wrote:
> Hi everyone,
> 
> This is a followup series to my A23 bare-minimum bringup series [1],
> which adds basic clock support for the A23 SoC. It is one of many
> split up from the original A23 series [2]. Yet to come are more
> clocks, reset controllers, pinctrl, prcm, and mmc.
> 
> The first patch fixes the reworked clock protection code merged in
> 3.16-rc1, which unintentionally made clock gates unprotectable.
> 
> The second patch moves the remaining "ahb_sdram" clock to the
> protected clock list, now that it works.
> 
> The third patch adds support for factor clocks that have an N factor
> not starting from 0. This is found on some PLLs in A31/A23.
> 
> The fourth patch adds table-based dividers for div clocks, as some
> clocks, such as apb0 divider on sun4/5/7i, apb1 on sun6/8i and axi
> on sun8i.
> 
> The fifth patch adds support for the basic clocks in the A23, just
> PLL1 for cpus, and the system bus clocks and gates.
> 
> The last patch adds the DT nodes for the newly added clocks.
> 
> Patch 1 should be merged for 3.16, while the rest should go in 3.17.

Why should it go in for 3.16? Is there any user for it yet?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/e30ab48f/attachment.sig>
