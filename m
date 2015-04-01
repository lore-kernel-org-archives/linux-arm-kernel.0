From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 1 Apr 2015 23:56:10 +0100
Subject: [PATCH v6 5/6] ARM: dts: Alpine platform devicetree
In-Reply-To: <55017e28.Jzshpkksg8eI/q72%tsahee@annapurnalabs.com>
References: <55017e28.Jzshpkksg8eI/q72%tsahee@annapurnalabs.com>
Message-ID: <20150401225609.GG24899@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Can we please get this patch reverted, or at least fixed - preferably
before the merge window opens!

> +dtb-$(CONFIG_ARCH_ALPINE) += alpine_db.dtb

Here, the filename contains an underscore.

> diff --git a/arch/arm/boot/dts/alpine-db.dts b/arch/arm/boot/dts/alpine-db.dts
> new file mode 100644
> index 0000000..dfb5a08
> --- /dev/null
> +++ b/arch/arm/boot/dts/alpine-db.dts

Here, the filename contains a hyphen.

Hence, when building a kernel with ARCH_ALPINE enabled, it fails to build,
and this screws up an otherwise fine allmodconfig build.

-- 
FTTC broadband for 0.8mile line: currently at 10.5Mbps down 400kbps up
according to speedtest.net.
