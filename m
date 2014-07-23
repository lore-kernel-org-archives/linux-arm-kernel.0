From: jason@lakedaemon.net (Jason Cooper)
Date: Wed, 23 Jul 2014 19:27:15 -0400
Subject: [PATCH 2/2] ARM: mvebu: Added dts defintion for Lenovo Iomega
 ix4-300d NAS
In-Reply-To: <1406155973-13657-1-git-send-email-yahoo@perenite.com>
References: <1406155973-13657-1-git-send-email-yahoo@perenite.com>
Message-ID: <20140723232715.GL23220@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Benoit,

This looks a lot better, thanks for turning it around so quickly!

My only general comment is just for the future.  When submitting new
versions of patches, please add a 'V2' inside the brackets on the
Subject line.  Or v3, or v4, or v14 in rare cases ;-)

It really helps us patch wranglers keep track of which version to apply.

One small comment below.

On Wed, Jul 23, 2014 at 03:52:53PM -0700, Benoit Masson wrote:
> The Lenovo Iomega ix4-300d is a 4-Bay sata NAS with dual Gb,
>  USB2.0 & 3.0, powered by a Marvell Armada XP MV78230 dual core CPU.
> 
> http://shop.lenovo.com/fr/fr/servers/network-storage/lenovoemc/ix4-300d/
> Signed-off-by: Benoit Masson <yahoo@perenite.com>
> ---
>  arch/arm/boot/dts/Makefile                      |   3 +-
>  arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts | 284 ++++++++++++++++++++++++
>  2 files changed, 286 insertions(+), 1 deletion(-)
>  create mode 100644 arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
...
> diff --git a/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
> new file mode 100644
> index 0000000..1f33cbc
> --- /dev/null
> +++ b/arch/arm/boot/dts/armada-xp-lenovo-ix4-300d.dts
...
> +	/* Warning: you need both eth1 & 0 PHY initialized
> +		(i.e having them up does the tweak)
> +		for poweroff to shutdown otherwise it reboots */

nit: multi-line comments are like this:

	/*
	 * Warning: you need both eth1 & 0 PHY initialized (i.e having
	 * them up does the tweak) for poweroff to shutdown otherwise it
	 * reboots
	 */

If that's the only thing left, I'll fix it up when I pull it in.  No
need to respin just for this.

thx,

Jason.
