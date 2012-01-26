From: stigge@antcom.de (Roland Stigge)
Date: Thu, 26 Jan 2012 17:04:36 +0100
Subject: [PATCH] Added phy3250_defconfig
In-Reply-To: <1327592865-16859-1-git-send-email-stigge@antcom.de>
References: <1327592865-16859-1-git-send-email-stigge@antcom.de>
Message-ID: <4F217994.2080906@antcom.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 01/26/2012 04:47 PM, Roland Stigge wrote:
> This patch provides a working default config for the reference board (PHY3250)
> of the NXP LPC32XX architecture. It is the first in a series of patches to
> provide more complete support for that architecture.

We recently discussed that the first step for better LPC32XX integration
would be a respective defconfig file.

With this patch (for Linux 3.3.0-rc1), I'm providing a phy3250_defconfig
that especially supports the reference design by PHYTEC. This is because
every supported board (including the PHY board) will have hardware
specific parameters that don't map very good to a reasonably general
lpc32xx_defconfig. Please tell me what you think about that.

Some further notes:

* I added LPC3XXX to mach-types because the bootloader on my PHY3250
board identifies as machine type no. 736.

* This is a minimal patch that makes lpc32xx compile and boot. I will
submit further drivers for LPC32xx building upon that.

* OHCI HCD is currently broken, disabled for now (already have a newer
one working, will submit later)

* The previously discussed update for clock.c will also follow in a
separate patch (currently compiles with several warnings).

You can have a preview for the remaining drivers at
http://git.antcom.de/ , repo "linux-2.6", branch "work92105".

Thanks in advance,

Roland
