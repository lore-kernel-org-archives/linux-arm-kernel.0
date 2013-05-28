From: arnd@linaro.org (Arnd Bergmann)
Date: Tue, 28 May 2013 22:11:28 +0200
Subject: [PATCH V8 0/3] USB: OHCI: Start splitting up the driver
In-Reply-To: <1369746291-21788-1-git-send-email-manjunath.goudar@linaro.org>
References: <1365746856-7772-2-git-send-email-manjunath.goudar@linaro.org>
 <1369746291-21788-1-git-send-email-manjunath.goudar@linaro.org>
Message-ID: <201305282211.28563.arnd@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 28 May 2013, Manjunath Goudar wrote:
> This series of patches begins the process of splitting ohci-hcd up into
> a core library module and independent pci driver modules.
> 

Seems to basically work now, but I'm getting run-time errors after
loading the driver, with patch 1/3 applied:

[15916.438452] input: Logitech USB-PS/2 Optical Mouse as /devices/pci0000:00/0000:00:12.0/usb3/3-1/3-1:1.0/input/input26
[15916.438584] hid-generic 0003:046D:C050.0017: input,hidraw0: USB HID v1.10 Mouse [Logitech USB-PS/2 Optical Mouse] on usb-0000:00:12.0-1/input0
[15917.465597] usb 3-3: new full-speed USB device number 3 using ohci-pci
[15917.636712] usb 3-3: New USB device found, idVendor=0ccd, idProduct=0077
[15917.636717] usb 3-3: New USB device strings: Mfr=1, Product=2, SerialNumber=0
[15917.636721] usb 3-3: Product: USB PnP Sound Device
[15917.636724] usb 3-3: Manufacturer: C-Media Electronics Inc.      
[15917.812827] input: C-Media Electronics Inc.       USB PnP Sound Device as /devices/pci0000:00/0000:00:12.0/usb3/3-3/3-3:1.3/input/input27
[15917.812919] hid-generic 0003:0CCD:0077.0018: input,hidraw1: USB HID v1.00 Device [C-Media Electronics Inc.       USB PnP Sound Device] on usb-0000:00:12.0-3/input3
[15918.789906] cannot submit urb (err = -18)
[15918.790163] cannot submit urb (err = -18)
[15918.842095] usb 7-1: new full-speed USB device number 2 using ohci-pci
[15919.883135] cannot submit urb (err = -18)
[15919.883604] cannot submit urb (err = -18)
[15919.883613] cannot submit urb (err = -18)
[15919.883616] cannot submit urb (err = -18)
[15919.883619] cannot submit urb (err = -18)
[15919.883623] cannot submit urb (err = -18)
[15919.883626] cannot submit urb (err = -18)
[15919.883629] cannot submit urb (err = -18)
[15919.883632] cannot submit urb (err = -18)
[15919.883639] delay: estimated 354, actual 1
[15919.883644] cannot submit urb (err = -18)
[15919.883647] delay: estimated 353, actual 0
[15919.883651] cannot submit urb (err = -18)

	Arnd
