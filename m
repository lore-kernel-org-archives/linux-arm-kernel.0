From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 29 Nov 2012 10:26:31 +0000
Subject: [PATCH 4/4] rtc: pxa: request rtc irqs when probe/remove the
 device
In-Reply-To: <1354155670-6267-4-git-send-email-chao.xie@marvell.com>
References: <1354155670-6267-1-git-send-email-chao.xie@marvell.com>
 <1354155670-6267-4-git-send-email-chao.xie@marvell.com>
Message-ID: <20121129102631.GH19440@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 28, 2012 at 09:21:10PM -0500, Chao Xie wrote:
> The original pxa_rtc_open/pxa_rtc_release will be called
> when the /dev/rtc0 is opened or closed.
> In fact, these two functions will register/unregister the irqs.
> User application will use /dev/rtc0 to read the rtc time or set
> the alarm. The rtc should still run indepent of open/close the
> rtc device.
> So only register the irqs when probe the device,
> and disable clock and unregister the irqs when remove the device.

Again, this is wrong.
