From: jason@lakedaemon.net (Jason)
Date: Wed, 22 Feb 2012 16:09:19 -0500
Subject: [PATCH 3/3] arm: kirkwood: convert uart0 to devicetree.
In-Reply-To: <201202222055.27698.arnd@arndb.de>
References: <cover.1329936660.git.jason@lakedaemon.net>
 <0ad28cac6d608253b01e1d57bb479a29754ae823.1329936660.git.jason@lakedaemon.net>
 <201202222055.27698.arnd@arndb.de>
Message-ID: <20120222210919.GK23524@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 22, 2012 at 08:55:27PM +0000, Arnd Bergmann wrote:
> On Wednesday 22 February 2012, Jason Cooper wrote:
> > This uart is common to all kirkwood SoC's, so I placed it in the
> > kirkwood.dtsi.
> > 
> > Signed-off-by: Jason Cooper <jason@lakedaemon.net>
> 
> I'm not sure how we are handling this for other platforms, but
> my feeling is that the serial port information should be in
> the board specific dts file, because there are multiple serial
> ports on the chips and individual boards may only provide one
> of them.

On closer inspection, it looks like the openrd board and the qnap boards
are including uart1, nothing else does.  I'll redo it and resubmit.

> Alternatively, you could list all serial ports in the dts file
> and use the linux,stdout-path "chosen" property to tell the
> kernel which one to use.

All of the boards use uart0 as the default tty, so I'm thinking uart0 is
declared in all boards (.dts), and the two that need it, declare uart1
in the same dts.

Does that sound right?

thx,

Jason.
