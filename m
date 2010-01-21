From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 21 Jan 2010 22:11:33 +0000
Subject: [PATCH] serial imx.c: fix CTS trigger level lower to avoid
	lost chars
In-Reply-To: <20100121220653.GA21010@pengutronix.de>
References: <1264109163-28739-1-git-send-email-valentin.longchamp@epfl.ch>
	<20100121220653.GA21010@pengutronix.de>
Message-ID: <20100121221133.GA30419@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 21, 2010 at 11:06:53PM +0100, Wolfram Sang wrote:
> CCing linux-serial
> 
> On Thu, Jan 21, 2010 at 10:26:03PM +0100, Valentin Longchamp wrote:
> > The imx CTS trigger level is left at its reset value that is 32
> > chars. Since the RX FIFO has 32 entries, when CTS is raised, the
> > FIFO already is full. However, some serial port devices first empty
> > their TX FIFO before stopping when CTS is raised, resulting in lost
> > chars.
> 
> ? Isn't that a flaw of the other side? Have you spotted other serial drivers
> doing the same as your patch?

Arguably, but it's common behaviour of 16550A's and similar.
