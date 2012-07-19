From: linux@prisktech.co.nz (Tony Prisk)
Date: Thu, 19 Jul 2012 14:51:12 +0000
Subject: [PATCH 1/2] ARM: vt8500: Update vt8500-ehci driver to support
 device tree.
In-Reply-To: <CABjd4YxfynH5f0dTwOh3EpiNr2vLq_2yJqys=Ztm_XV2oY4nsw@mail.gmail.com>
References: <1342704684-4858-1-git-send-email-linux@prisktech.co.nz>,
 <CABjd4YxfynH5f0dTwOh3EpiNr2vLq_2yJqys=Ztm_XV2oY4nsw@mail.gmail.com>
Message-ID: <76F764B079F92A4E843589C893D0A022C3812198@SERVER.prisktech.co.nz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Alexey Charkov [alchark at gmail.com]
Sent: 20 July 2012 02:45
To: vt8500-wm8505-linux-kernel at googlegroups.com
Cc: Arnd Bergmann; linux-arm-kernel at lists.infradead.org; devicetree-discuss at lists.ozlabs.org; Tony Prisk
Subject: Re: [PATCH 1/2] ARM: vt8500: Update vt8500-ehci driver to support device tree.

2012/7/19 Tony Prisk <linux@prisktech.co.nz>:
> Signed-off-by: Tony Prisk <linux@prisktech.co.nz>
> ---
>  drivers/usb/host/ehci-vt8500.c |    9 +++++++++
>  1 files changed, 9 insertions(+), 0 deletions(-)

Have you tried to use ehci-platform on VIA/WMT devices? If it works
(which I would expect), I believe it's better to include OF support
into ehci-platform and drop ehci-vt8500 completely after existing
boards are converted to Device Tree. When writing ehci-vt8500, I
mostly only copied stuff from the PCI version and made it initialize
from the platform bus (nothing specific to vt8500).

Thanks,
Alexey


-----
Alexey,

The biggest problem I have at the moment is that its very hard to test anything
as I only have a WM8650 which isn't supported in mainline.

I think I have a local copy of 'our' repo on my laptop - If I do, I'll try changing the
platform_device to use ehci_platform and see if it works.

Arnd,

There isn't any reason why it couldn't be uhci_of. I was simply trying to preserve
our existing platform support without having to introduce more patches for the
board files. The existing uhci-grlib is probably a better candidate though as I noticed
its been updated to support OF since I wrote this driver, and this driver is based off
that one.

Regards

Tony P
