From: voice.shen@atmel.com (Bo Shen)
Date: Tue, 13 Jan 2015 10:15:17 +0800
Subject: [PATCH v3 0/5] usb: atmel_usba_udc: Rework errata handling
In-Reply-To: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1421060278-27329-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <54B47FB5.8080807@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 01/12/2015 06:57 PM, Boris Brezillon wrote:
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
> Changes since v2:
> - remove UTF8 character in commit message of patch 2
>
> Changes since v1:
> - cache INT_ENB value to speedup INT_ENB read operations

For the whole series, test OK on at91sam9m10g45ek board with mass 
storage gadget, test OK on sama5d36ek with serial gadget.

Tested-by: Bo Shen <voice.shen@atmel.com>

> Boris Brezillon (5):
>    usb: atmel_usba_udc: Rework at91sam9rl errata handling
>    usb: atmel_usba_udc: Add at91sam9g45 and at91sam9x5 errata handling
>    ARM: at91/dt: update udc compatible strings
>    usb: atmel_usba_udc: Mask status with enabled irqs
>    usb: gadget: atmel_usba: Cache INT_ENB register value
>
>   .../devicetree/bindings/usb/atmel-usb.txt          |   5 +-
>   arch/arm/boot/dts/at91sam9g45.dtsi                 |   2 +-
>   arch/arm/boot/dts/at91sam9x5.dtsi                  |   2 +-
>   arch/arm/boot/dts/sama5d3.dtsi                     |   2 +-
>   arch/arm/boot/dts/sama5d4.dtsi                     |   2 +-
>   drivers/usb/gadget/udc/atmel_usba_udc.c            | 146 +++++++++++++--------
>   drivers/usb/gadget/udc/atmel_usba_udc.h            |   9 ++
>   7 files changed, 111 insertions(+), 57 deletions(-)
>

Best Regards,
Bo Shen
