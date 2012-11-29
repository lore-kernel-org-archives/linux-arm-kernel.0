From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2012 10:25:19 +0000
Subject: [PATCH 1/4] rtc: sa1100: enable/disable rtc when probe/remove
 the device
In-Reply-To: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
Message-ID: <20121129102519.GG19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 09:21:07PM -0500, Chao Xie wrote:
> The original sa1100_rtc_open/sa1100_rtc_release will be called
> when the /dev/rtc0 is opened or closed.
> In fact, these two functions will enable/disable the clock, and
> register/unregister the irqs.
> User application will use /dev/rtc0 to read the rtc time or set
> the alarm. The rtc should still run indepent of open/close the
> rtc device.
> So only enable clock and register the irqs when probe the device,
> and disable clock and unregister the irqs when remove the device.

NAK.  I don't think you properly understand what's going on here if you
think moving the entire open and release functions into the probe and
remove functions is the right thing to do.
