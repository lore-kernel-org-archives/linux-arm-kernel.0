From: sr@denx.de (Stefan Roese)
Date: Thu, 24 Mar 2016 13:05:29 +0100
Subject: [PATCH v2] spi: orion.c: Add direct access mode
In-Reply-To: <20160324112308.GY2566@sirena.org.uk>
References: <20160322173546.40d24cc2@free-electrons.com>
 <56F17684.2010307@denx.de> <20160323113316.GH2566@sirena.org.uk>
 <56F2852C.5010006@denx.de> <20160323125448.GM2566@sirena.org.uk>
 <56F295E1.4030505@denx.de> <20160323132732.GN2566@sirena.org.uk>
 <56F2D19A.7020604@denx.de> <20160323183952.GK5250@lunn.ch>
 <56F37EFF.2090605@denx.de> <20160324112308.GY2566@sirena.org.uk>
Message-ID: <56F3D809.5060803@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 24.03.2016 12:23, Mark Brown wrote:
> On Thu, Mar 24, 2016 at 06:45:35AM +0100, Stefan Roese wrote:
> 
>> Right. It is of course possible to use this direct mode to access
>> SPI flash. Its just not the way how the SPI MTD driver uses the
>> SPI controller. All information that is written to the SPI flash
>> (e.g. commands, addresses) are passed as plain tx-data in the SPI
>> message to the SPI controller. And it would be not easy to detect
>> commands / addresses vs. "real data" in this orion SPI driver
>> to put these values into the specific registers.
> 
> We now have extensions for passing commands through directly (see
> spi_flash_read()).

Interesting. So this direct access mode can be used to interface
with SPI flash using these extensions. Great.

But I hope that its not a requirement that I add this SPI flash
support (via direct access mode) to the orion SPI driver to get
this patch accepted. As it really was not the scope of my project.
I can try to get this added later, but I can't make any promises
here. Perhaps someone else finds the time to implement this?

Thanks,
Stefan
