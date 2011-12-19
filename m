From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 19 Dec 2011 12:08:05 +0800
Subject: serial tty name
In-Reply-To: <4EE8C16F.8060501@calxeda.com>
References: <20111214144344.GA2090@richard-laptop>
 <4EE8C16F.8060501@calxeda.com>
Message-ID: <20111219040804.GF4962@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 14, 2011 at 09:31:59AM -0600, Rob Herring wrote:
> Richard,
> 
> On 12/14/2011 08:43 AM, Richard Zhao wrote:
> > How to map different uart port to ttymxc0 (take imx for example)?
> > 
> > In rootfs, it usually "getty ttymxc0"  to get
> > serial console. And the rootfs may be shared by different boards.
> > Traditionaly way is to set right platform device ID.
> > 
> > But with DT, UART2 always generate ttymxc1, UART3 for ttymxc2. You
> > always needs to modify the getty command when your change another board.
> > 
> > Is there a way to fix it?
> 
> That's what the aliases are for.
> 
I understand it differently.  The aliases was introduced to help
tty/serial driver identify the correct hardware port for given serial
node from device tree.  (Ab)using it to fool 'console' setting may
eventually confuse users, saying they will think the uart port on his
board is UART0.

-- 
Regards,
Shawn
