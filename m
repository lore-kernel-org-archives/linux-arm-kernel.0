From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 11 Oct 2013 21:15:27 +0200
Subject: [PATCH] wdt: sunxi: Fix section mismatch
In-Reply-To: <1380982817-10234-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1380982817-10234-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20131011191527.GO3041@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Wim,

On Sat, Oct 05, 2013 at 04:20:17PM +0200, Maxime Ripard wrote:
> This driver has a section mismatch, for probe and remove functions,
> leading to the following warning during the compilation.
> 
> WARNING: drivers/watchdog/built-in.o(.data+0x24): Section mismatch in
> reference from the variable sunxi_wdt_driver to the function
> .init.text:sunxi_wdt_probe()
> The variable sunxi_wdt_driver references
> the function __init sunxi_wdt_probe()
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

It would be great if it could go in 3.12.

Do you want to take it, or can I merge it through my tree, with your
Acked-by?

Thanks,
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131011/0789ceb6/attachment.sig>
