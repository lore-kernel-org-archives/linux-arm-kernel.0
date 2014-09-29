From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 29 Sep 2014 15:57:24 +0200
Subject: ARMADA 370 - Kernel panic during boot
In-Reply-To: <d1be3a0a37860f969b99ecc09b4cfcd8@twien.net>
References: <6241a6200de0d573c982f73f062ed7fa@twien.net>
 <542938A7.8050307@free-electrons.com>
 <d1be3a0a37860f969b99ecc09b4cfcd8@twien.net>
Message-ID: <20140929155724.579964b5@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 29 Sep 2014 13:25:03 +0200, post at twien.net wrote:

> 	soc {
> 		ranges = <MBUS_ID(0xf0, 0x01) 0 0xd0000000 0x100000

Are you really sure about the 0xd0000000 value here? Your earlyprintk
works using CONFIG_DEBUG_MVEBU_UART_ALTERNATE=y according to
your .config, which indicates that your internal registers are mapped at
0xf1000000 and not@0xd0000000 as your Device Tree indicates.

Can you change this line to:

	ranges = <MBUS_ID(0xf0, 0x01) 0 0xf1000000 0x100000

And try again?

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
