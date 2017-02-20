From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 20 Feb 2017 13:59:55 +0100
Subject: [PATCH] ARM: dts: kirkwood: Fix SATA pinmux-ing for TS419
In-Reply-To: <20170218003251.GC4152@decadent.org.uk>
References: <20170218003251.GC4152@decadent.org.uk>
Message-ID: <20170220135955.63fbcaa3@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Adding in Cc all the maintainers of the Kirkwood platforms.

On Sat, 18 Feb 2017 00:32:51 +0000, Ben Hutchings wrote:

> +&pmx_sata0 {
> +	marvell,pins = "mpp15";
> +};
> +
> +&pmx_sata1 {
> +	marvell,pins = "mpp16";
> +};

This is not only muxing mpp15 as sata0 and mpp16 as sata1, but also
removes the muxing of sata0/sata1 pins described in kirkwood-6282.dtsi:

                        pmx_sata0: pmx-sata0 {
                                marvell,pins = "mpp5", "mpp21", "mpp23";
                                marvell,function = "sata0";
                        };
                        pmx_sata1: pmx-sata1 {
                                marvell,pins = "mpp4", "mpp20", "mpp22";
                                marvell,function = "sata1";
                        };

So it means that MPP 4, 5, 20, 21, 22 and 23 will no longer be muxed as
sata0/sata1. Is this really what you want?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
