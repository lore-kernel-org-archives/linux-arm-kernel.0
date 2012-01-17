From: davem@davemloft.net (David Miller)
Date: Tue, 17 Jan 2012 12:39:29 -0500 (EST)
Subject: [PATCH V3 1/4] CS89x0 : add platform driver support
In-Reply-To: <1326570996-27818-1-git-send-email-jaccon.bastiaansen@gmail.com>
References: <1326570996-27818-1-git-send-email-jaccon.bastiaansen@gmail.com>
Message-ID: <20120117.123929.1033968651111164006.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jaccon Bastiaansen <jaccon.bastiaansen@gmail.com>
Date: Sat, 14 Jan 2012 20:56:36 +0100

> -	depends on ISA || EISA || MACH_IXDP2351 || ARCH_IXDP2X01 \
> -		|| MACH_MX31ADS || MACH_QQ2440 || (ARM && ARCH_EP93XX) || MAC
> +	depends on ISA || EISA || ARM || (ARM && ARCH_EP93XX) || MAC

The expression "ARM || (ARM && ARCH_EP93XX)" should be reduced to
just plain "ARM", which is equivalent.
