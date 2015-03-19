From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Thu, 19 Mar 2015 11:36:29 +0100
Subject: [PATCH 00/12] USB: chipidea: patchset for performance improvement
In-Reply-To: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
References: <1426727963-32280-1-git-send-email-peter.chen@freescale.com>
Message-ID: <20150319103629.GI14457@ns203013.ovh.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09:19 Thu 19 Mar     , Peter Chen wrote:
> Hi all,
> 
> In this patch set, I add some interfaces for tuning the performance
> of chipidea usb driver. With this set, the USB performance can be improved
> at some user cases with suitable parameters. The main changes:
> 
> - Interface to tune interrupt threshold control, and set
> 'Immediate' for default value
> - The glue layer can disable stream mode according to USB role
> - Interface to tune AHB burst configuration at SBUSCFG
> - Interface to tune tx/rx burst size
> - i.mx changes for achieving better performance, it can reduce
>   the latecy between bus and USB FIFO, and reduce the overrun
>   and underrun occurrences, it is useful for the system bus is busy.
>   we see great improvement for ISO transfer, eg, high resolution
>   USB camera when the bus is busy.
> 
> Below are some test results at imx6sx sdb board
> (set ehci_hcd.park=3 at bootargs), the tests are done
> at v4.0 kernel, no other bus loading during the tests,
> so we have not seen performance change for some use cases.
> 
> USB Mass Storage (Host mode)
> With Patch Set		Without Patch Set
> R: 26.9 MB/s		27 MB/s
> W: 25.2 MB/s		24.5 MB/s
> 
> 1G USB Ethernet Card
> With Patch Set		Without Patch Set
> TX: 186 Mb/s		185 Mb/s
> RX: 219 Mb/s		216 Mb/s
> 
> g_ncm (Device Mode)
> With Patch Set		Without Patch Set
> TX: 166MB/s		163MB/s
> RX: 230MB/s		184MB/s

The improve is not drag sticks except for gcm RX

The most interesting path will be on full system loaded

can you test it and provide data?

Best Regards,
J.
