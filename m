From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 7 Jan 2015 22:03:13 +0100
Subject: [PATCH v2 0/5] usb: atmel_usba_udc: Rework errata handling
In-Reply-To: <1420552022-8422-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1420552022-8422-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <20150107210313.GC2447@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The whole series looks good to me, you can add my
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>



On 06/01/2015 at 14:46:57 +0100, Boris Brezillon wrote :
> Hello,
> 
> Here is a set of patches porting existing at91sam9rl erratum handling to
> DT and adding new code to handle at91sam9g45/9x5 erratum.
> It also adds several compatible strings to differentiate those errata.
> 
> These patches should be backported to 3.17 and 3.18 stable releases but
> they do not apply cleanly on those stable branches.
> I'll send a backport of this series once it is merged in mainline.
> 
> Regards,
> 
> Boris
> 
> Changes since v1:
> - cache INT_ENB value to speedup INT_ENB read operations
> 
> Boris Brezillon (5):
>   usb: atmel_usba_udc: Rework at91sam9rl errata handling
>   usb: atmel_usba_udc: Add at91sam9g45 and at91sam9x5 errata handling
>   ARM: at91/dt: update udc compatible strings
>   usb: atmel_usba_udc: Mask status with enabled irqs
>   usb: gadget: atmel_usba: Cache INT_ENB register value
> 
>  .../devicetree/bindings/usb/atmel-usb.txt          |   5 +-
>  arch/arm/boot/dts/at91sam9g45.dtsi                 |   2 +-
>  arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
>  arch/arm/boot/dts/sama5d3.dtsi                     |   2 +-
>  arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
>  drivers/usb/gadget/udc/atmel_usba_udc.c            | 146 +++++++++++++--------
>  drivers/usb/gadget/udc/atmel_usba_udc.h            |   9 ++
>  7 files changed, 111 insertions(+), 57 deletions(-)
> 
> -- 
> 1.9.1
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
