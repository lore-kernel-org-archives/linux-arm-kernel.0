From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 22 Feb 2012 20:55:27 +0000
Subject: [PATCH 3/3] arm: kirkwood: convert uart0 to devicetree.
In-Reply-To: <0ad28cac6d608253b01e1d57bb479a29754ae823.1329936660.git.jason@lakedaemon.net>
References: <cover.1329936660.git.jason@lakedaemon.net>
 <0ad28cac6d608253b01e1d57bb479a29754ae823.1329936660.git.jason@lakedaemon.net>
Message-ID: <201202222055.27698.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 22 February 2012, Jason Cooper wrote:
> This uart is common to all kirkwood SoC's, so I placed it in the
> kirkwood.dtsi.
> 
> Signed-off-by: Jason Cooper <jason@lakedaemon.net>

I'm not sure how we are handling this for other platforms, but
my feeling is that the serial port information should be in
the board specific dts file, because there are multiple serial
ports on the chips and individual boards may only provide one
of them.

Alternatively, you could list all serial ports in the dts file
and use the linux,stdout-path "chosen" property to tell the
kernel which one to use.

	Arnd
