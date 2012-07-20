From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 20 Jul 2012 22:05:28 +0000
Subject: [PATCHv2 1/2] ARM: vt8500: Update vt8500-ehci driver to support
 device tree.
In-Reply-To: <1342787373-2230-1-git-send-email-linux@prisktech.co.nz>
References: <1342787373-2230-1-git-send-email-linux@prisktech.co.nz>
Message-ID: <201207202205.28815.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 20 July 2012, Tony Prisk wrote:
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  .../devicetree/bindings/usb/vt8500-ehci.txt        |   10 ++++++++++
>  drivers/usb/host/ehci-vt8500.c                     |    9 +++++++++
>  2 files changed, 19 insertions(+), 0 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/usb/vt8500-ehci.txt

As mentioned, you need to Cc the USB mailing list and the EHCI maintainers:

$ ./scripts/get_maintainer.pl drivers/usb/host/ehci-vt8500.c -f
Alan Stern <stern@rowland.harvard.edu> (maintainer:USB EHCI DRIVER)
Greg Kroah-Hartman <gregkh@linuxfoundation.org> (supporter:USB SUBSYSTEM)
linux-usb at vger.kernel.org (open list:USB EHCI DRIVER)
linux-kernel at vger.kernel.org (open list)


> diff --git a/Documentation/devicetree/bindings/usb/vt8500-ehci.txt b/Documentation/devicetree/bindings/usb/vt8500-ehci.txt
> new file mode 100644
> index 0000000..74f75c6
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/usb/vt8500-ehci.txt
> @@ -0,0 +1,10 @@
> +VIA VT8500 and Wondermedia WM8xxx SoC USB controllers.
> +
> +Required properties:
> + - compatible: Should be "via,vt8500-ehci" or "wm,prizm-ehci".

I would list the interrupts and reg properties as required as well,
and you can mention that there must be exactly one interrupt and one
reg resource with a length of 0x200 bytes.

	Arnd
