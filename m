From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 7 Nov 2016 16:14:48 +0000
Subject: [PATCH] ARM: cache-uniphier: include <linux/errno.h> instead of
 <linux/types.h>
In-Reply-To: <1478534334-15562-1-git-send-email-yamada.masahiro@socionext.com>
References: <1478534334-15562-1-git-send-email-yamada.masahiro@socionext.com>
Message-ID: <20161107161448.GJ1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 08, 2016 at 12:58:54AM +0900, Masahiro Yamada wrote:
> Nothing in this header file depends on <linux/types.h>.
> Rather, <linux/errno.h> should be included for -ENODEV.

So how do we end up with a definition for u32?

I think you need both these include files.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
