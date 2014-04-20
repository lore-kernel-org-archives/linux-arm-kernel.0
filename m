From: gregkh@linuxfoundation.org (Greg KH)
Date: Sun, 20 Apr 2014 09:58:37 -0700
Subject: [RFC PATCH 0/2] usb: Reuse fsl driver code for synopsys usb
 controller
In-Reply-To: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
References: <7aed4ee6-69e7-4f9f-9f45-675bc695089c@CO9EHSMHS031.ehs.local>
Message-ID: <20140420165837.GA5423@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 20, 2014 at 09:57:03PM +0530, Punnaiah Choudary Kalluri wrote:
> Zynq soc contains a dual role usb controller and this IP is from synopsys. We
> observed that there is driver available for this controller from freescale and
> decided to reuse this driver for zynq use.
> 
> Here is the link for zynq soc TRM. Please refer chapter 15 for usb controller
> related information.
> http://www.xilinx.com/support/documentation/user_guides/ug585-Zynq-7000-TRM.pdf
> 
> The following series of patches add initial support for zynq soc in fsl gadget controller
> driver and fsl host controller driver.
> 
> Based on these patches, I have the following concerns and sugesstions
> 
> Since the freescale usb driver is for synopsys IP, Please consider rebranding
> this driver name and config options to reflect that it is a sysnopsys IP. So
> that other vendors who using this IP can reuse thie driver.

The config options can be edited to show the new hardware support, but
we don't usually rename kernel drivers, sorry.  That just gets messy in
the end, and the "first one here gets to name it" is usually enforced.
No users ever see a kernel driver name, especially for a gadget driver,
so it shouldn't ever really matter.

thanks,

greg k-h
