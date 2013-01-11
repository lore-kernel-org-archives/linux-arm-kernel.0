From: olof@lixom.net (Olof Johansson)
Date: Fri, 11 Jan 2013 10:07:00 -0800
Subject: [PATCH 2/5] ARM: mach-shmobile: fix memory size for
 kota2_defconfig
In-Reply-To: <1357888626-4946-3-git-send-email-horms+renesas@verge.net.au>
References: <1357888626-4946-1-git-send-email-horms+renesas@verge.net.au>
 <1357888626-4946-3-git-send-email-horms+renesas@verge.net.au>
Message-ID: <CAOesGMiUh-cb4xtizarm1ah06zvawu4r3zV1NOM9bwqXO3SwHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 10, 2013 at 11:17 PM, Simon Horman
<horms+renesas@verge.net.au> wrote:
> The CONFIG_MEMORY_SIZE value is interpreted as a 32 bit integer, which
> makes sense on a system without PAE. It appears that a trailing 0 was
> appended to the value and after some testing it appears that 0x1e000000 is
> the correct value.
>
> Without this patch, building kota2_defconfig results in:
>
> /home/arnd/linux-arm/arch/arm/kernel/setup.c:790:2: warning: large integer implicitly truncated to unsigned type [-Woverflow]
>
> Reported-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Olof Johansson <olof@lixom.net>
> Signed-off-by: Simon Horman <horms+renesas@verge.net.au>

Acked-by: Olof Johansson <olof@lixom.net>

Or is this the only fix you have right now, so I should just apply it directly?

-Olof
