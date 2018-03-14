From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Wed, 14 Mar 2018 07:16:12 +0100
Subject: [PATCH] usb: misc: supports Apple Carplay driver
In-Reply-To: <1521007356-12306-2-git-send-email-chunfeng.yun@mediatek.com>
References: <1521007356-12306-1-git-send-email-chunfeng.yun@mediatek.com>
 <1521007356-12306-2-git-send-email-chunfeng.yun@mediatek.com>
Message-ID: <20180314061612.GA17263@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 14, 2018 at 02:02:36PM +0800, Chunfeng Yun wrote:
> The driver is used to support Apple carplay feature by a debugfs
> interface which can force the driver to send a USB Vendor Request
> of "Apple Device to Host Mode Switch" to switch Apple Device
> into host mode.

While I am all for crazy debugfs interfaces, I would _strongly_ suggest
not doing that here for the main API to the device.  I know Android is
trying to prevent any new devices from even enabling debugfs, and as the
file system requires root permissions by default, you are forcing any
user of your new api to run as root, which is not a good idea either.

Given that all you are doing here is a single usb control message, why
does this even need to be a kernel driver at all?  Can't you do the same
thing from userspace with a simple libusb/usbfs program?  Or even a
simple script?

thanks,

greg k-h
