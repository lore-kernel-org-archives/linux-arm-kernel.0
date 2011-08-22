From: gigin_jose@yahoo.co.in (GIGIN JOSE)
Date: Mon, 22 Aug 2011 09:17:43 +0000 (UTC)
Subject: USB host on s3c2416
Message-ID: <loom.20110822T110123-860@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, 

I am working on samsung s3c2416 ARM based Soc on 
linux 2.6.21 kernel. By default, the Soc has one 
USB host and one USB device/host. My USB host is 
working fine. Since I need to use two USB host on my system,
 I need to enable the USB device/host as a USB host. 

The following are the changes I have made for the same:

Register  Address        value
-----------------------------
PHYPWR    0x4C00_0084    0x0
PWRCFG    0x4C00_0060    (1<<4)
URSTCON   0x4C00_0088    (0<<2)|(1<<1)|(1<<0)
URSTCON   0x4C00_0088    (0<<2)|(0<<1)|(0<<0)
PHYCTRL   0x4C00_0080    (0<<3)|(0<<2)|(1<<1)|(1<<0)
UCLKCON   0x4C00_008C    0<<31)|(0<<2)|(1<<1)|(1<<0)

Once I try to plug in a  USB mass storage device (whose driver is present in 
kernel), I get the following error:

usb 1-2: new full speed USB device using s3c2410-ohci and address 10
usb 1-2: device descriptor read/64, error -62
usb 1-2: device descriptor read/64, error -62
usb 1-2: new full speed USB device using s3c2410-ohci and address 11
usb 1-2: device descriptor read/64, error -62
usb 1-2: device descriptor read/64, error -62
usb 1-2: new full speed USB device using s3c2410-ohci and address 12
usb 1-2: device not accepting address 12, error -62
usb 1-2: new full speed USB device using s3c2410-ohci and address 13
usb 1-2: device not accepting address 13, error -62


Why is it throwing this error ? Is there any driver for USB hub missing in 
2.6.21 kernel, or do I need to modify more on register settings. 

Please help. 

Thank You
GIGIN
