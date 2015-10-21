From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 20 Oct 2015 21:03:16 -0600
Subject: [PATCH] bcm2835: Add Raspberry Pi thermal sensor to the device
 tree
In-Reply-To: <1444592937-16320-1-git-send-email-lkundrak@v3.sk>
References: <1444592937-16320-1-git-send-email-lkundrak@v3.sk>
Message-ID: <56270074.90501@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10/11/2015 01:48 PM, Lubomir Rintel wrote:
> Driven via the Raspberry Pi VideoCore 4 firmware interface.

>  .../bindings/thermal/raspberrypi,bcm2835-thermal.txt        | 13 +++++++++++++
>  arch/arm/boot/dts/bcm2835-rpi.dtsi                          |  5 +++++

There should be a separate patch for the DT binding and DT additions,
but they can be in a series. As before, CC at least the DT binding to
the DT binding maintainers.

> diff --git a/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal.txt b/Documentation/devicetree/bindings/thermal/raspberrypi,bcm2835-thermal.txt

> +Raspberry Pi Broadcom BCM2835 thermal control
> +
> +Required properties:

This needs some more explanation of what this is intended to represent
and do. For example, what services is this node (the driver instantiated
by this node) expected to implement, and what firmware services is it
expected to rely upon?
