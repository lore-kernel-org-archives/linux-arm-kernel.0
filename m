From: spk.linux@gmail.com (Sachin Kamat)
Date: Tue, 5 Aug 2014 17:05:19 +0530
Subject: [PATCH RESEND] usb: ehci/ohci-exynos: Fix PHY getting sequence
In-Reply-To: <1407235148-31790-1-git-send-email-gautam.vivek@samsung.com>
References: <1407235148-31790-1-git-send-email-gautam.vivek@samsung.com>
Message-ID: <CAK5sBcGq1XzCkLz_f5q+5ik9shQSJ=pqzQkrtXbKzJFYfOUnPw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vivek,

On Tue, Aug 5, 2014 at 4:09 PM, Vivek Gautam <gautam.vivek@samsung.com> wrote:
> Since we want to keep support for both older usb-phys as well as the
> newer generic phys, lets first get the generic PHYs and fallback to
> older USB-PHYs only when we fail to get the former.
> This should fix the issue with ehci-exynos and ohci-exynos, wherein
> in the absence of SAMSUNG_USB2PHY config symbol, we end up getting
> the NOP_USB_XCEIV phy when the same is enabled. And thus the PHYs
> are not configured properly.
>
> Reported-by: Sachin Kamat <sachin.kamat@samsung.com>
> Signed-off-by: Vivek Gautam <gautam.vivek@samsung.com>
> Cc: Alan Stern <stern@rowland.harvard.edu>
> Cc: Jingoo Han <jg1.han@samsung.com>

Tested this patch on Exynos5250 based Arndale and Snow boards.
Fixes the said issue. Thanks.

Tested-by: Sachin Kamat <sachin.kamat@samsung.com>

-- 
Regards,
Sachin.
