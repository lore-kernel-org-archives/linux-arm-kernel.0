From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 15 Jul 2016 22:42:54 +0200
Subject: [PATCH] dt: bindings: Add a generic ethernet device binding
In-Reply-To: <1468405204-5845-1-git-send-email-hdegoede@redhat.com>
References: <1468405204-5845-1-git-send-email-hdegoede@redhat.com>
Message-ID: <1788846.r3134d1VMR@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, July 13, 2016 12:20:04 PM CEST Hans de Goede wrote:
> +&mmc1 {
> +       non-removable;
> +       status = "okay";
> +
> +       sdio_wifi: sdio_wifi at 1 {
> +               compatible = "generic,ethernet"
> +               reg = <1>;
> +       };
> +};

For discoverable buses, we normally use a compatible property that
reflects the device ID on that bus, e.g. on PCI we have "pci1A2B:3C4D",
and I think that makes more sense than having to come up with strings
for sdio devices.

In fact, Linux completely ignores the compatible strings on those
buses (pci, usb, sdio, ...), so I think we can just do the same thing
using no compatible string at all.

	Arnd
