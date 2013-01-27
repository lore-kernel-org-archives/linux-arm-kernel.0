From: sameo@linux.intel.com (Samuel Ortiz)
Date: Mon, 28 Jan 2013 00:52:59 +0100
Subject: [PATCH 09/26] mfd: ab8500-debugfs: Provide a means for a user
 subscribe to IRQs
In-Reply-To: <1358254566-12419-10-git-send-email-lee.jones@linaro.org>
References: <1358254566-12419-1-git-send-email-lee.jones@linaro.org>
 <1358254566-12419-10-git-send-email-lee.jones@linaro.org>
Message-ID: <20130127235259.GO1174@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lee,

On Tue, Jan 15, 2013 at 12:55:49PM +0000, Lee Jones wrote:
> Allow users to subscribe to and view IRQ events live from debugfs.
I seem to remember that I got a similar patch some time ago for the same
purpose and my answer was: Please use a UIO driver for this. There already is
such driver, it's uio_pdrv_genirq. What your debugfs registration entry could
do is adding a platform device for the specific interrupt number. This would
avoid the irq handler registration and the sysfs entry creation, both things I
believe are not very elegant and open coded. It also gives you an IRQ count
implementation.
Ideally, the UIO framework could be improved to support IRQ ranges (through
IRQ domains) instead of the current single interrupt number.

Have you considered going through that path ?

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
