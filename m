From: stern@rowland.harvard.edu (Alan Stern)
Date: Mon, 11 Jan 2016 11:11:05 -0500 (EST)
Subject: [PATCH 1/1] USB: core: let USB device know device node
In-Reply-To: <1452501535-8580-1-git-send-email-peter.chen@freescale.com>
Message-ID: <Pine.LNX.4.44L0.1601111109580.1631-100000@iolanthe.rowland.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 11 Jan 2016, Peter Chen wrote:

> Although most of USB devices are hot-plug's, there are still some devices
> are hard wired on the board, eg, for HSIC and SSIC interface USB devices.
> If these kinds of USB devices are multiple functions, and they can supply
> other interfaces like i2c, gpios for other devices, we may need to
> descirbe these at device tree.
> 
> In this commit, it uses "reg" in dts as port number to match the port
> number decided by USB core, if they are the same, then the device node
> is for the device we are creating for USB core.
> 
> Signed-off-by: Peter Chen <peter.chen@freescale.com>

> --- a/include/linux/usb.h
> +++ b/include/linux/usb.h
> @@ -25,6 +25,7 @@
>  struct usb_device;
>  struct usb_driver;
>  struct wusb_dev;
> +struct devcie_node;

You misspelled "device".

Alan Stern
