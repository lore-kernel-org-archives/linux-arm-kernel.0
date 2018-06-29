From: trini@konsulko.com (Tom Rini)
Date: Fri, 29 Jun 2018 16:53:16 -0400
Subject: [U-Boot, 3/4] ARM: mach-omap2: omap5/dra7: Enable ACTLR[0]
 (Enable invalidates of BTB) to facilitate CVE_2017-5715 WA in OS
In-Reply-To: <20180612202411.29798-4-nm@ti.com>
References: <20180612202411.29798-4-nm@ti.com>
Message-ID: <20180629205316.GK18596@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 03:24:10PM -0500, Nishanth Menon wrote:

> Enable CVE_2017_5715 and since we have our own v7_arch_cp15_set_acr
> function to setup the bits, we are able to override the settings.
> 
> Without this enabled, Linux kernel reports:
> CPU0: Spectre v2: firmware did not set auxiliary control register IBE bit, system vulnerable
> 
> With this enabled, Linux kernel reports:
> CPU0: Spectre v2: using ICIALLU workaround
> 
> NOTE: This by itself does not enable the workaround for CPU1 (on
> OMAP5 and DRA72/AM572 SoCs) and may require additional kernel patches.
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>

Applied to u-boot/master, thanks!

-- 
Tom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180629/413e1c95/attachment.sig>
