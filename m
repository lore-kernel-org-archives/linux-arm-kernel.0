From: robh@kernel.org (Rob Herring)
Date: Wed, 8 Jun 2016 15:22:57 -0500
Subject: [PATCH v2 2/5] mfd: add Ricoh RN5T567 PMIC support
In-Reply-To: <20160608010429.19618-3-stefan@agner.ch>
References: <20160608010429.19618-1-stefan@agner.ch>
 <20160608010429.19618-3-stefan@agner.ch>
Message-ID: <20160608202257.GA22463@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 07, 2016 at 06:04:26PM -0700, Stefan Agner wrote:
> The Ricoh RN5T567 is from the same family as the Ricoh RN5T618 is,
> the differences are:
> 
> + DCDC4
> + Slightly different output voltage/currents
> + 32kHz Output
> - ADC/Charger capabilities
> 
> Reviewed-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
> Signed-off-by: Stefan Agner <stefan@agner.ch>
> ---
>  Documentation/devicetree/bindings/mfd/rn5t618.txt | 19 ++++++++++-------
>  drivers/mfd/Kconfig                               |  7 +++---
>  drivers/mfd/rn5t618.c                             | 26 +++++++++++++++++------
>  include/linux/mfd/rn5t618.h                       | 12 +++++++++++
>  4 files changed, 46 insertions(+), 18 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/mfd/rn5t618.txt b/Documentation/devicetree/bindings/mfd/rn5t618.txt
> index 937785a..5b493ed 100644
> --- a/Documentation/devicetree/bindings/mfd/rn5t618.txt
> +++ b/Documentation/devicetree/bindings/mfd/rn5t618.txt
> @@ -1,18 +1,21 @@
> -* Ricoh RN5T618 PMIC
> +* Ricoh RN5T567/RN5T618 PMIC
>  
> -Ricoh RN5T618 is a power management IC which integrates 3 step-down
> -DCDC converters, 7 low-dropout regulators, a Li-ion battery charger,
> -fuel gauge, ADC, GPIOs and a watchdog timer. It can be controlled
> -through a I2C interface.
> +Ricoh RN5T567/RN5T618 is a power management IC family which integrates
> +3 to 5 step-down DCDC converters, 7 low-dropout regulators, GPIOs and

I count 4?

Otherwise, for the binding:

Acked-by: Rob Herring <robh@kernel.org>
