From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 23 Aug 2012 14:37:43 +0200
Subject: [PATCH 4/4] [RFC] ARM: treewide: manually change more mach-*/*.h
 includes
In-Reply-To: <201208231135.11688.arnd@arndb.de>
References: <201208221253.07278.arnd@arndb.de>
 <201208221301.19439.arnd@arndb.de>
 <20120822214323.GA12255@n2100.arm.linux.org.uk>
 <201208231135.11688.arnd@arndb.de>
Message-ID: <50362417.9070600@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/23/2012 01:35 PM, Arnd Bergmann :
> On Wednesday 22 August 2012, Russell King - ARM Linux wrote:
>>
>> On Wed, Aug 22, 2012 at 01:01:19PM +0000, Arnd Bergmann wrote:
>>> These are lots of device drivers that include machine
>>> specific header files from ARM platforms and that are
>>> not easily scriptable. The changes have been found through
>>> manual inspection and should cause no visible changes
>>> because of the build script that maps the old names to the
>>> new ones.

[..]

> How about I move all the pure platform data definition files now and
> rebase the other patches on top of that. Here is a list of suggested
> file names in include/linux/platform_data/:
> 
> mach-at91/at_hdmac.h		-> dma-atmel.h

Fine with me. Maybe atmel-dma.h can better match what we already have in
this directory, but I do not know what is the policy in this directory...

[..]


> ** list of mach/* inclusions that I could not match with
> ** exactly one ARM platform:

In fact, for "*atmel*" type of files, they usually match *both* AVR32
and ARM/AT91 devices: so, we have to be careful about them...

Best regards,
-- 
Nicolas Ferre
