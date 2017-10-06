From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Fri, 6 Oct 2017 15:15:21 +0200
Subject: [PATCH 16/16] arm64: dts: marvell: armada-3720-espressobin:
 fill UART nodes
In-Reply-To: <87fuawe8gx.fsf@free-electrons.com>
References: <20171006101344.15590-1-miquel.raynal@free-electrons.com>
 <20171006101344.15590-17-miquel.raynal@free-electrons.com>
 <87fuawe8gx.fsf@free-electrons.com>
Message-ID: <20171006151521.440418a2@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Fri, 06 Oct 2017 15:01:18 +0200, Gregory CLEMENT wrote:

>  /*
>   * To enable the second UART on J17 (pins 24,26) refer to the uart1
>   * node from armada-3720-db.dts.
>   * Note that TX and RX signal are the ones coming directly from the SoC:
>   * 1.8V TTL.
>   */

One issue with this comment (and Miqu?l's version as well) is that it
does not explain why you don't enable this UART by default.

The real reason is in the commit log from Miqu?l, and should probably
be part of the comment. Perhaps something like:

/*

 * Connector J17 (pins X, Y, Z) exposes a number of different
 * features:
 *  - UART1 (pins 24 = RX, pins 26 = TX), see armada-3720-db.dts for an
 *    example on how to enable UART1. Beware that the signals are 1.8V
 *    TTL.
 *  - SPIxyz
 *  - I2Cxyz
 */

Otherwise, it's not clear at all why you don't just enable UART1. Or
perhaps I misunderstood Miqu?l's commit log ?

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
