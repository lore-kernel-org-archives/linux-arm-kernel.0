From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 28 Mar 2013 13:00:39 -0400
Subject: [PATCH] ARM: Kirkwood: fix unused mvsdio gpio pins
In-Reply-To: <1364043420-17641-1-git-send-email-sebastian.hesselbarth@gmail.com>
References: <1364043420-17641-1-git-send-email-sebastian.hesselbarth@gmail.com>
Message-ID: <20130328170039.GW13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 23, 2013 at 01:56:58PM +0100, Sebastian Hesselbarth wrote:
> mvsdio_platform_data allows to pass card detect and write protect gpio
> numbers to the driver. Some kirkwood boards don't use both pins as they
> are not connected, and don't set the corresponding value in platform_data.
> 
> This will leave the unset values in platform_data initialized as 0, which
> is in fact a valid gpio pin. mvsdio will grab that pin and configure it as
> gpio, which in turn breaks nand controller as mpp0 also carries nand_io2.
> 
> This patch fixes the above by initializing unused gpio functions in the
> platform_data with an invalid (-1) value.
> 
> Signed-off-by: Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
> Reported-by: Soeren Moch <smoch@web.de>
> ---
> Cc: Soeren Moch <smoch@web.de>
> Cc: Jason Cooper <jason@lakedaemon.net>
> Cc: Andrew Lunn <andrew@lunn.ch>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-kernel at vger.kernel.org
> ---
>  arch/arm/mach-kirkwood/guruplug-setup.c  |    2 ++
>  arch/arm/mach-kirkwood/openrd-setup.c    |    1 +
>  arch/arm/mach-kirkwood/rd88f6281-setup.c |    1 +
>  3 files changed, 4 insertions(+)

Applied to mvebu/fixes

thx,

Jason.
