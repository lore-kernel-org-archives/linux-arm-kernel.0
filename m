From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Mon, 7 Jan 2013 08:48:45 -0800
Subject: [PATCH 3.9] Driver for 7-segment displays connected over GPIOs
In-Reply-To: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
References: <1357576928-29133-1-git-send-email-thomas.petazzoni@free-electrons.com>
Message-ID: <20130107164845.GA2911@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 07, 2013 at 05:42:05PM +0100, Thomas Petazzoni wrote:
> Dear drivers/{char,misc}/ maintainers,
> 
> This patch series implements a simple driver for 7-segment displays
> connected over GPIOs through a BCD encoder. The userspace interface of
> the driver is very simple: just a "value" file in the sysfs directory
> of the device, which can be written to (changes the value shown on the
> 7-segment display) and read (gives the current value).

If you ever add/remove/modify sysfs files, you have to also do the same
for the Documentation/ABI/ files as well, please redo that in this patch
series.

But, the bigger question is, why is this a kernel driver at all?  Can't
you do this from userspace today without any new kernel code?

thanks,

greg k-h
