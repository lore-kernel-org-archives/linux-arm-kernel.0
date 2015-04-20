From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 20 Apr 2015 16:54:32 +0200
Subject: [tpmdd-devel] [RFC PATCH 1/2] tee: generic TEE subsystem
In-Reply-To: <20150420050800.GA12928@obsidianresearch.com>
References: <1429257057-7935-1-git-send-email-jens.wiklander@linaro.org>
 <1429257057-7935-2-git-send-email-jens.wiklander@linaro.org>
 <20150417163054.GA28241@obsidianresearch.com>
 <20150418090147.GF12732@n2100.arm.linux.org.uk>
 <20150418172923.GA10605@obsidianresearch.com>
 <20150418215755.GM12732@n2100.arm.linux.org.uk>
 <20150420050800.GA12928@obsidianresearch.com>
Message-ID: <20150420145432.GD7261@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 19, 2015 at 11:08:00PM -0600, Jason Gunthorpe wrote:
> I still suspect the expected way to write a new mid layer is to create
> your own struct device and not rely on misc_device,

Yes, that is the way.  You can not use misc_device for anything other
than creating the char node that your driver can use through the fileops
you pass to it.

Do not use a misc_device to create sysfs files for, or anything else, it
will be wrong and racy, as you have pointed out.

thanks,

greg k-h
