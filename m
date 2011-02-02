From: subaparts@yandex.ru (Alexander Sverdlin)
Date: Wed, 02 Feb 2011 20:33:19 +0300
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <20110202165959.GT12743@opensource.wolfsonmicro.com>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
	<20110202125327.GO12743@opensource.wolfsonmicro.com>
	<1296653211.1504.40.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEFD45C8@AUSP01VMBX24.collaborationhost.net>
	<20110202165959.GT12743@opensource.wolfsonmicro.com>
Message-ID: <1296667999.1504.44.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Wed, 2011-02-02 at 17:00 +0000, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 10:53:15AM -0600, H Hartley Sweeten wrote:
> 
> > I don't have any problem with leaving the reset management in the codec.
> > The enable (chip-select) should be handled in the platform code.  But,
> > gpio_disable should be removed from struct cs4271_platform_data to avoid
> > any confusion.
> 
> Is that really a chip select or is it a power control?
> 

It's a chip select. The way I've managed it in CODEC it's because Cirrus
boards do not have any other SPI devices. Supported by current mainline,
at least.
