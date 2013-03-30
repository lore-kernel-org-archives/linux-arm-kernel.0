From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 30 Mar 2013 12:49:09 +0000
Subject: [PATCH v3 6/7] USB: EHCI: make ehci-msm a separate driver
In-Reply-To: <Pine.LNX.4.44L0.1303291607090.1467-100000@iolanthe.rowland.org>
References: <Pine.LNX.4.44L0.1303291607090.1467-100000@iolanthe.rowland.org>
Message-ID: <201303301249.09239.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 29 March 2013, Alan Stern wrote:
> On Thu, 28 Mar 2013, Arnd Bergmann wrote:

> This patch is good.  However the ehci-msm driver itself is not.  While
> checking through the code, I was struck by the fact that it never calls
> usb_add_hcd() or usb_remove_hcd().  Obviously the driver cannot work
> properly.
> 
> In addition, it stores the PHY pointer in a global variable.  
> (ehci-atmel does much the same thing for its clocks.)  This means the
> driver cannot be used on a system having more than one EHCI controller.  
> Maybe this doesn't matter, though.
> 
> Maybe somebody would like to fix and test it...

I'm not too surprised. The driver was added the last time that the MSM
maintainers started a serious attempt to get a lot of their code mainlined,
a little over two years ago. While there is some activity from Qualcomm
in specific areas of the code every now and then, they literally have
thousands of patches on top of the kernel that they use in actual
products and I would not expect a mainline kernel to actually work on
any recent Qualcomm hardware.

	Arnd
