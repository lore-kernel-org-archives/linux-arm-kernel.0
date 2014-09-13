From: jason@lakedaemon.net (Jason Cooper)
Date: Sat, 13 Sep 2014 17:08:29 -0400
Subject: [PATCH reword] ARM: MVEBU: Netgear RN102: Use Hardware BCH ECC
In-Reply-To: <1410339341-3372-1-git-send-email-klightspeed@killerwolves.net>
References: <1410339341-3372-1-git-send-email-klightspeed@killerwolves.net>
Message-ID: <20140913210829.GI30828@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 10, 2014 at 06:55:41PM +1000, klightspeed at killerwolves.net wrote:
> The bootloader on the Netgear ReadyNAS RN102 uses Hardware BCH ECC
> (strength = 4), while the pxa3xx NAND driver by default uses 
> Hamming ECC (strength = 1).
> 
> This patch changes the ECC mode on these machines to match that
> of the bootloader and of the stock firmware. That way, it is
> now possible to update the kernel from userland (e.g. using
> standard tools from mtd-utils package); u-boot will happily
> load and boot it.
> 
> Fixes: 92beaccd8b49 ("ARM: mvebu: Enable NAND controller in ReadyNAS 102 .dts file")
> Signed-off-by: Ben Peddell <klightspeed@killerwolves.net>
> Acked-by: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
> Tested-by: Arnaud Ebalard <arno@natisbad.org>
> ---
>  arch/arm/boot/dts/armada-370-netgear-rn102.dts | 4 ++++
>  1 file changed, 4 insertions(+)

I've already applied this the mvebu/fixes:

  500abb6ccb9e ARM: mvebu: Netgear RN2120: Use Hardware BCH ECC

thx,

Jason.
