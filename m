From: gregkh@linuxfoundation.org (Greg KH)
Date: Thu, 29 Nov 2018 08:49:36 +0100
Subject: [PATCH v4 4/6] coresight: Use PMU driver configuration for sink
 selection
In-Reply-To: <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
References: <1543442478-31465-1-git-send-email-mathieu.poirier@linaro.org>
 <1543442478-31465-5-git-send-email-mathieu.poirier@linaro.org>
Message-ID: <20181129074936.GE12347@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2018 at 03:01:16PM -0700, Mathieu Poirier wrote:
> This patch uses the PMU driver configuration held in event::hw::drv_config
> to select a sink for each event that is created (the old sysFS way of
> working is kept around for backward compatibility).

It is "sysfs", no InterCaps please, I've never called it that in the
past.

And just use sysfs, if that does not work properly, then fix that, don't
create yet-another-way-to-configure-this-thing to just confuse people.

thanks,

greg k-h
