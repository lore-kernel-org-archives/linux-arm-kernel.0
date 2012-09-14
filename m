From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Sep 2012 10:28:57 -0600
Subject: [PATCH V4 1/2] of: Add generic device tree DMA helpers
In-Reply-To: <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
References: <1347573629-21299-1-git-send-email-jon-hunter@ti.com>
 <1347573629-21299-2-git-send-email-jon-hunter@ti.com>
Message-ID: <50535B49.7070706@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/13/2012 04:00 PM, Jon Hunter wrote:
> This is based upon the work by Benoit Cousson [1] and Nicolas Ferre [2]
> to add some basic helpers to retrieve a DMA controller device_node and the
> DMA request/channel information.

> diff --git a/Documentation/devicetree/bindings/dma/dma.txt b/Documentation/devicetree/bindings/dma/dma.txt

> +* Generic DMA Controller and DMA request bindings
> +
> +Generic binding to provide a way for a driver using DMA Engine to retrieve the
> +DMA request or channel information that goes from a hardware device to a DMA
> +controller.
> +
> +
> +* DMA controller
> +
> +Required property:
> +- #dma-cells: 		Must be at least 1. Used to provide DMA controller
> +			specific information. See DMA client binding below for
...
> +* DMA client
> +
> +Client drivers should specify the DMA property using a phandle to the controller
> +followed by DMA controller specific data.
> +
> +Required property:
> +- dmas:			List of one or more DMA specifiers, each consisting of
> +			- A phandle pointing to DMA controller node
> +			- A single integer cell containing DMA controller
> +			  specific information. This typically contains a dma
> +			  request line number or a channel number, but can
> +			  contain any data that is used required for configuring
> +			  a channel.

"A single integer cell" doesn't sound correct; shouldn't this be
something like "a number of integer cells, as determined by the
#dma-cells property in the node referenced by phandle"?

> +- dma-names: 		Contains one identifier string for each dma specifier in
> +			the dmas property. The specific strings that can be used
> +			are defined in the binding of the DMA client device.
