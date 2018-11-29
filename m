From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 29 Nov 2018 08:48:19 +0100
Subject: [PATCH v4 2/6] perf/core: Use ioctl to communicate driver
 configuration to kernel
In-Reply-To: <1543442478-31465-3-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-3-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20181129074819.GD12347@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 03:01:14PM -0700, Mathieu Poirier wrote:
> This patch adds the mechanic needed for user space to send PMU specific
> configuration to the kernel driver using an ioctl() command.  That way
> events can keep track of options that don't fit in the perf_event_attr
> structure like the selection of a CoreSight sink to use for the session.

This is what configfs is for, please use that instead of a generic "send
a string to the kernel for it to parse" type of thing.  No other driver
does this (or if they do, they should not), so this driver should not do
it as well, sorry.

greg k-h
