From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 13 Feb 2015 10:09:19 +0100
Subject: [PATCH 02/11] ARM: sunxi: always select RESET_CONTROLLER
In-Reply-To: <1423770163-583064-3-git-send-email-arnd@arndb.de>
References: <1423770163-583064-1-git-send-email-arnd@arndb.de>
 <1423770163-583064-3-git-send-email-arnd@arndb.de>
Message-ID: <20150213090919.GB4567@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On Thu, Feb 12, 2015 at 08:42:34PM +0100, Arnd Bergmann wrote:
> A lot of drivers for mach-sunxi depend on RESET_CONTROLLER. While
> this is selected for the drivers that have it, we keep running
> into build errors in drivers that are used on both the SoCs with
> and without a reset controller.
> 
> This patch moves the select statements into the common sunxi
> Kconfig option, which solves multiple such problems.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Maxime Ripard <maxime.ripard@free-electrons.com>

Chen-Yu already submitted the exact same patch a few days ago:
http://lists.infradead.org/pipermail/linux-arm-kernel/2015-February/322806.html

I was waiting for -rc1 to merge it, but I guess your way would work
too.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150213/4cfd5442/attachment.sig>
