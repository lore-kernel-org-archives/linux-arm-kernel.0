From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 30 Sep 2014 12:08:29 +0200
Subject: [PATCH v4] ARM: shmobile: r8a7790: link PCI USB devices to USB PHY
In-Reply-To: <6141061.UF13qqqgfz@wasted.cogentembedded.com>
References: <6141061.UF13qqqgfz@wasted.cogentembedded.com>
Message-ID: <2349534.Ie3QeIWjJF@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 29 September 2014 22:21:59 Sergei Shtylyov wrote:
> +
> +               usb at 0,1 {
> +                       reg = <0x800 0 0 0 0>;
> +                       device_type = "pci";
> +                       phys = <&usb0 0>;
> +                       phy-names = "usb";
> +               };
> +
> +               usb at 0,2 {

Nice to see this actually works!

The patch looks good to me, but I wasn't sure if the ARM PCI code handled
of_nodes correctly.

We frequently get people asking for the same functionality on USB device,
which should really work the same way, so I guess I can point them at
this now.

	Arnd
