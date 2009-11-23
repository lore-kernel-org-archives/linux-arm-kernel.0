From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Mon, 23 Nov 2009 12:00:01 +0000
Subject: [PATCH 06/12] imx-ssi sound driver
In-Reply-To: <ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
References: <1258645706-9071-1-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-2-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-3-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-4-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-5-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-6-git-send-email-s.hauer@pengutronix.de>
	<1258645706-9071-7-git-send-email-s.hauer@pengutronix.de>
	<ed82fe3e0911211812i49342b0eg2afe861c866db90c@mail.gmail.com>
Message-ID: <20091123120000.GC24326@rakim.wolfsonmicro.main>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Nov 21, 2009 at 08:12:34PM -0600, Timur Tabi wrote:

> Why did you write a new SSI driver when there already is one in sound/soc/fsl?

I can't speak for Sascha here but the i.MX BSPs provided by your
colleagues on the i.MX team also have an independant driver for the SSI
port.  The latest public version of the Freescale i.MX code I'm aware of
is in the recent Ubuntu kernels - I've not yet checked but I'd not be
surprised to see substantial code sharing between Sascha's code and the
BSP for the SSI-specific bits.

It would be very much desirable to unify the various drivers, though I
would prefer to avoid making this a blocker for getting i.MX3x "DMA"
support in mainline.  Taking a brief glance through the code it looks
like there's some platform-specifics in the drivers - the i.MX one has
optional DMA support due to the whole SDMA issue, while the PowerPC one
is including asm/immap_86xx.h for something.  Perhaps pulling the common
code into a library would be a good approach here?
