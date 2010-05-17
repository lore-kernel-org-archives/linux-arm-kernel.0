From: s.hauer@pengutronix.de (Sascha Hauer)
Date: Mon, 17 May 2010 10:06:10 +0200
Subject: [PATCH 0/3 v2] mx31moboard: OTG host support
In-Reply-To: <1273589871-25424-1-git-send-email-philippe.retornaz@epfl.ch>
References: <1273589871-25424-1-git-send-email-philippe.retornaz@epfl.ch>
Message-ID: <20100517080610.GG31199@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 11, 2010 at 04:57:48PM +0200, Philippe R?tornaz wrote:
> Hello
> 
> This patch set add the OTG host support for the eyebot robot.
> 
> The first patch fix the usb PHY reset so we really do reset and configure 
> the pad pull-up/down so the signal are stable while applying the reset 
> signal (observed with an oscilloscope).
> 
> The last two patches are adding a new number to the mx31moboard_baseboard 
> bootparam so we can choose at boot if we want an usb device or host on the 
> smartbot board.
> 
> v2: I've added Acked-by from Valentin on the first two patches, fixed
> some typo and modified the last patch according to Valentin comment.

Ok, applied.

Sascha

> 
> Regards,
> Philippe
> 
> Philippe R?tornaz (3):
>   mx31moboard: Fix usb PHY reset
>   mx31moboard: Move usb OTG device registration
>   mx31moboard: OTG host support for smartbot board
> 
>  arch/arm/mach-mx3/mach-mx31moboard.c               |  104 +++++++-------------
>  arch/arm/mach-mx3/mx31moboard-devboard.c           |    9 ++
>  arch/arm/mach-mx3/mx31moboard-marxbot.c            |    8 ++
>  arch/arm/mach-mx3/mx31moboard-smartbot.c           |   45 ++++++++-
>  arch/arm/plat-mxc/include/mach/board-mx31moboard.h |    3 +-
>  5 files changed, 100 insertions(+), 69 deletions(-)
> 
> 

-- 
Pengutronix e.K.                           |                             |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
Peiner Str. 6-8, 31137 Hildesheim, Germany | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |
