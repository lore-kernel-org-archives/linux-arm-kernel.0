From: ra7055@freescale.com (Rob Herring)
Date: Wed, 02 Jun 2010 08:08:35 -0500
Subject: [PATCH 1/3] mxc: Add support for the imx51 3-stack board
In-Reply-To: <20100602073650.GK26820@pengutronix.de>
References: <1275405043-18230-1-git-send-email-jason77.wang@gmail.com>
	<1275405043-18230-2-git-send-email-jason77.wang@gmail.com>
	<20100602073650.GK26820@pengutronix.de>
Message-ID: <1275484115.6821.10.camel@ra7055-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2010-06-02 at 09:36 +0200, Sascha Hauer wrote:
> Hi Jason,
> 
> On Tue, Jun 01, 2010 at 11:10:41PM +0800, Jason Wang wrote:
> > 3-stack is a reference board from Freescale for their i.MX51 SoC.
> > 
> > Add board definition, Kconfig and Makefile to enable Freescale 3-stack
> > board.
> 
> The debug board code looks the same like in mach-mx31_3ds.c. Does
> anybody know how similar the different debug boards for the 3ds boards
> are? ATM we only have the mx31_3ds with debug board support in the
> kernel. This could be the moment to go for a arch/arm/plat-mxc/3ds-debugboard.c

All debug boards are the same h/w design. The CPLD program has changed
for muxed addr and data bus support on MX51, but it retains
compatibility with other boards. The interface mode is set automatically
by signals tied off on the personality board, so there are no s/w
differences. 

Rob
