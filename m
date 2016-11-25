From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 25 Nov 2016 23:06:28 +0100
Subject: [PATCH] ARM: pxa: ezx: fix a910 camera data
In-Reply-To: <87inrbqr16.fsf@belgarion.home>
References: <20161124162955.3887066-1-arnd@arndb.de>
 <87inrbqr16.fsf@belgarion.home>
Message-ID: <3367313.o4F01WBXRf@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, November 25, 2016 8:48:53 PM CET Robert Jarzmik wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
> 
> > The camera_supply_dummy_device definition is shared between a780 and a910,
> > but only provided when the first is enabled and fails to build for a
> > configuration with only a910:
> >
> > arch/arm/mach-pxa/ezx.c:1097:3: error: 'camera_supply_dummy_device' undeclared here (not in a function)
> >
> > This moves the definition into its own section.
> >
> > Fixes: 6c1b417adc8f ("ARM: pxa: ezx: use the new pxa_camera platform_data")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> 
> Ah yes, I'll queue that up in pxa/fixes.
> 
> This also means that you have a test robot which beats my Jenkins, as mine
> didn't complain. Do you have a specific defconfig or is it a randconfig which
> reveals that ?
> 

It showed up in randconfig builds, two out of several hundred.
I'm not surprised that nobody else caught it.

	Arnd
