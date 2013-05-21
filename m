From: gregkh@linuxfoundation.org (Greg KH)
Date: Tue, 21 May 2013 11:40:46 -0700
Subject: [PATCH 00/19] driver:usb&net: add missing platform_driver owner
In-Reply-To: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
References: <1369104120-35552-1-git-send-email-libo.chen@huawei.com>
Message-ID: <20130521184046.GA7827@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 21, 2013 at 10:42:00AM +0800, Libo Chen wrote:
> I find a lot of mistakes using struct platform_driver without owner.
> So I pick up some of them including usb and net modules

Like others said, make the function call a macro that sets the module
owner in it, like all of the other major subsystem registration calls do
(usb_drivers, pci_drivers, etc.)

thanks,

greg k-h
