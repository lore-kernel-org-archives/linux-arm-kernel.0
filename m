From: sre@ring0.de (Sebastian Reichel)
Date: Mon, 9 Sep 2013 15:39:17 +0200
Subject: [PATCH 4/4] RX-51: Add platform function and data for bq24150a
 charger
In-Reply-To: <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
References: <1378630239-10006-1-git-send-email-pali.rohar@gmail.com>
 <1378630239-10006-5-git-send-email-pali.rohar@gmail.com>
Message-ID: <20130909133916.GA28917@earth.universe>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Pali,

On Sun, Sep 08, 2013 at 10:50:39AM +0200, Pali Roh?r wrote:
> This patch will register bq24150a charger in RX-51 board data.
> Patch also adding platform function between isp1704 and bq2415x
> drivers for detecting charger type.
> 
> So finally charging battery on Nokia N900 (RX-51) working
> automatically without any proprietary Nokia bits in userspace.

cool :)

> index 9c2dd10..a993ffe 100644
> --- a/arch/arm/mach-omap2/board-rx51-peripherals.c
> +++ b/arch/arm/mach-omap2/board-rx51-peripherals.c

AFAIK platform code for omap3 based boards is supposed to be removed
in the near future [0]. Device Tree does not support the glue layer, so
probably a small rx51 specific driver is needed.

[0] https://lkml.org/lkml/2013/8/12/70

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130909/f57a5e5d/attachment-0001.sig>
