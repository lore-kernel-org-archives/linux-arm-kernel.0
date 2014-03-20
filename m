From: nsekhar@ti.com (Sekhar Nori)
Date: Thu, 20 Mar 2014 17:59:32 +0530
Subject: [PATCH 07/62] ARM: davinci: make dm644x-evm phy fixup conditional
In-Reply-To: <1395257399-359545-8-git-send-email-arnd@arndb.de>
References: <1395257399-359545-1-git-send-email-arnd@arndb.de>
 <1395257399-359545-8-git-send-email-arnd@arndb.de>
Message-ID: <532ADF2C.4040405@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 March 2014 12:59 AM, Arnd Bergmann wrote:
> We cannot call phy_register_fixup_for_uid() if CONFIG_PHYLIB
> is not built into the kernel, and we should not enforce that
> to be built into vmlinux either, because one might want to
> disable the entire network stack.
> 
> This change uses a compile-time condition on CONFIG_PHYLIB
> to remove the call in the cases where it cannot work.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Sekhar Nori <nsekhar@ti.com>
> Cc: Kevin Hilman <khilman@deeprootsystems.com>
> Cc: davinci-linux-open-source at linux.davincidsp.com

Acked-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
