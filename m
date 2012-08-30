From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 30 Aug 2012 18:24:52 +0100
Subject: [PATCH 05/10] ARM: at91: explicitly include mach/gpio.h
In-Reply-To: <20120830171446.GC7629@game.jcrosoft.org>
References: <1346279496-26286-1-git-send-email-robherring2@gmail.com>
 <1346279496-26286-6-git-send-email-robherring2@gmail.com>
 <20120830171446.GC7629@game.jcrosoft.org>
Message-ID: <20120830172452.GB18957@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 30, 2012 at 07:14:46PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 17:31 Wed 29 Aug     , Rob Herring wrote:
> > From: Rob Herring <rob.herring@calxeda.com>
> > 
> > In preparation to remove implicit inclusion of mach/gpio.h, add explict
> > include of mach/gpio.h.
> I'm going to drop it for 3.7 too
> 
> the attached patch will do the same but in a more simpler way

I wonder whether you read your patches before you send them... it's
sometimes quite a good idea to review your own patches. :)

> diff --git a/arch/arm/mach-at91/gpio.c b/arch/arm/mach-at91/gpio.c
> index c5d7e1e..6803baa 100644
> --- a/arch/arm/mach-at91/gpio.c
> +++ b/arch/arm/mach-at91/gpio.c
> @@ -30,6 +30,7 @@
>  #include <mach/at91_pio.h>
>  
>  #include "generic.h"
> +#include "generic.h"

That's fairly obviously wrong.
