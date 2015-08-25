From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 25 Aug 2015 11:30:19 +0100
Subject: [PATCH-v2 1/5] mfd: 88pm800: Fix tabbing issue
In-Reply-To: <55DC2A51.6090008@linaro.org>
References: <1440442594-3102-1-git-send-email-vaibhav.hiremath@linaro.org>
 <1440442594-3102-2-git-send-email-vaibhav.hiremath@linaro.org>
 <20150825075121.GE19409@x1> <55DC2A51.6090008@linaro.org>
Message-ID: <20150825103019.GP19409@x1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:
> On Tuesday 25 August 2015 01:21 PM, Lee Jones wrote:
> >On Tue, 25 Aug 2015, Vaibhav Hiremath wrote:
> >
> >>Driver had coding style issues where spaces were used instead
> >>of tabs. This patch fixes them all.
> >
> >That's not all it's doing though is it?
> >
> 
> Yes, its just tabbing related fixes.

No, it's really not.

> >Please describe all of your changes.

... we're also taking the opportunity to remove the unnecessary
protection surrounding some of the defined values.

> >>Signed-off-by: Vaibhav Hiremath <vaibhav.hiremath@linaro.org>
> >>---
> >>  drivers/mfd/88pm800.c | 125 ++++++++++++++++++++++++--------------------------
> >>  1 file changed, 61 insertions(+), 64 deletions(-)
> >>
> >>diff --git a/drivers/mfd/88pm800.c b/drivers/mfd/88pm800.c
> >>index f104a32..c4e097d 100644
> >>--- a/drivers/mfd/88pm800.c
> >>+++ b/drivers/mfd/88pm800.c
> >>@@ -30,55 +30,55 @@
> >>  #include <linux/of_device.h>
> >>
> >>  /* Interrupt Registers */
> >>-#define PM800_INT_STATUS1		(0x05)
> >>+#define PM800_INT_STATUS1		0x05
> >>  #define PM800_ONKEY_INT_STS1		(1 << 0)
> >>  #define PM800_EXTON_INT_STS1		(1 << 1)
> >>-#define PM800_CHG_INT_STS1			(1 << 2)
> >>-#define PM800_BAT_INT_STS1			(1 << 3)
> >>-#define PM800_RTC_INT_STS1			(1 << 4)
> >>+#define PM800_CHG_INT_STS1		(1 << 2)
> >>+#define PM800_BAT_INT_STS1		(1 << 3)
> >>+#define PM800_RTC_INT_STS1		(1 << 4)
> >>  #define PM800_CLASSD_OC_INT_STS1	(1 << 5)
> >
> >These should all be replaced by BIT().
> >
> >Please fix the whole file.
> 
> Will do.
> 
> Thanks,
> Vaibhav

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
