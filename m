From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Wed, 2 Feb 2011 12:53:27 +0000
Subject: [PATCH] EDB93xx: Add support for CS4271 CODEC on EDB93xx boards
In-Reply-To: <1296645167.1504.31.camel@r60e>
References: <1296603653.1504.9.camel@r60e>
	<0D753D10438DA54287A00B027084269764CEF59B2B@AUSP01VMBX24.collaborationhost.net>
	<1296643688.1504.23.camel@r60e>
	<20110202104943.GN12743@opensource.wolfsonmicro.com>
	<1296645167.1504.31.camel@r60e>
Message-ID: <20110202125327.GO12743@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 02, 2011 at 02:12:47PM +0300, Alexander Sverdlin wrote:

> On 07 OCT 2010 you advised to integrate GPIO handling (reset and
> SPI-enable) into CODEC code flow.

> Now Hartley suggested to move GPIO handling to platform code. This makes
> sense, as SPI-enable will be managed automatically, and reset is also
> more related to platform (depending on schematics, inversion and so on).

What is the advantage of this?  The GPIO management has to be done
somewhere and replicating it in every platform seems like a complete
waste of time.  Given that one of the GPIOs is a power control it'll
also mean that it's not possible to manage the power dynamically at
runtime.
