From: Sudeep.Holla@arm.com (Sudeep Holla)
Date: Fri, 07 Feb 2014 14:48:26 +0000
Subject: [PATCH 10/21] ARM: MM: Add DT binding for Feroceon L2 cache
In-Reply-To: <1391730137-14814-11-git-send-email-andrew@lunn.ch>
References: <1391730137-14814-1-git-send-email-andrew@lunn.ch>
 <1391730137-14814-11-git-send-email-andrew@lunn.ch>
Message-ID: <52F4F23A.3030405@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/02/14 23:42, Andrew Lunn wrote:
> Instantiate the L2 cache from DT. Indicate in DT where the cache
> control register is and if write through should be made.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>
> ---
>  .../devicetree/bindings/arm/mrvl/foroceon.txt      | 19 +++++++++
>  arch/arm/boot/dts/kirkwood.dtsi                    |  5 +++
>  arch/arm/include/asm/hardware/cache-feroceon-l2.h  |  2 +
>  arch/arm/mach-kirkwood/board-dt.c                  | 15 +------
>  arch/arm/mm/cache-feroceon-l2.c                    | 46 ++++++++++++++++++++++
>  5 files changed, 73 insertions(+), 14 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> 
> diff --git a/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt b/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> new file mode 100644
> index 000000000000..8058676d1476
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/mrvl/foroceon.txt
> @@ -0,0 +1,19 @@
> +* Marvell Feroceon Cache
> +
> +Required properties:
> +- compatible : Should be "marvell,feroceon-kirkwood".
> +- reg        : Address of the L2 cache control register
> +
> +Optional properties:
> +- writethrough : only if present, the cache will be used in write through mode.
> +

Looks more like a software configuration for me unless I am missing something.
It should not be here IMO if its pure software construct, may be you can use
already existing cachepolicy kernel parameter instead.

Also its better to Cc DT mailing list for any binding updates.

Regards,
Sudeep
