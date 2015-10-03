From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Sat, 3 Oct 2015 19:02:20 +0200
Subject: [PATCH v3 1/2] ARM: at91/dt: shdwc binding: add new shutdown
 controller documentation
In-Reply-To: <1443630121-13912-2-git-send-email-nicolas.ferre@atmel.com>
References: <1443630121-13912-1-git-send-email-nicolas.ferre@atmel.com>
 <1443630121-13912-2-git-send-email-nicolas.ferre@atmel.com>
Message-ID: <20151003170220.GG2694@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/09/2015 at 18:22:00 +0200, Nicolas Ferre wrote :
> +SHDWC Shutdown Controller (Alternative)
> +
> +1) shdwc node
> +
> +required properties:
> +- compatible: should be "atmel,sama5d2-shdwc".
> +- reg: should contain registers location and length
> +- clocks: phandle to input clock.
> +- #address-cells: should be one. The cell is the wake-up input index.
> +- #size-cells: should be zero.
> +
> +optional properties:
> +
> +- atmel,wakeup-debouncer: minimum wake-up inputs debouncer period in

Shouldn't that property be called atmel,wakeup-debouncer-ms ?

> +
> +2) input nodes
> +
> +Wake-up input nodes are usually described in the "board" part of the Device
> +Tree. Note also that input 0 is linked to the wake-up pin and is frequently
> +used.
> +
> +Required properties:
> +- reg: should contain the wake-up input index [0 - 15].
> +
> +Optional properties:
> +- atmel,wakeup-type: string, operation mode of the input described by the child
> +  node. Supported values are: "high" or "low".
> +

Maybe we could avoid parsing string and use an integer with a few defines

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
