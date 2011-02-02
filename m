From: subaparts@yandex.ru (Alexander Sverdlin)
Date: Wed, 02 Feb 2011 14:12:47 +0300
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <20110202104943.GN12743@opensource.wolfsonmicro.com>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
Message-ID: <1296645167.1504.31.camel@r60e>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Mark,

On Wed, 2011-02-02 at 10:49 +0000, Mark Brown wrote:
> On Wed, Feb 02, 2011 at 01:48:08PM +0300, Alexander Sverdlin wrote:
> 
> > I'm really confused now, where should it be? If I will init
> > cs4271_platform_data with GPIO values, CODEC driver will manage it.
> > Otherwise CODEC driver should be rewritten without GPIO support and I
> > can add it to platform code.
> 
> What is the problem?
> 

On 07 OCT 2010 you advised to integrate GPIO handling (reset and
SPI-enable) into CODEC code flow.

Now Hartley suggested to move GPIO handling to platform code. This makes
sense, as SPI-enable will be managed automatically, and reset is also
more related to platform (depending on schematics, inversion and so on).

As for me, I think handle it in platform code is better. So we can now
remove all the GPIO code and cs4271_platform_data structure from CS4271
CODEC.

Best regards,
	Alexander.
