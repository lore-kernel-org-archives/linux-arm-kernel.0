From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 16 Jul 2014 19:30:35 +0200
Subject: [PATCH v3] i2c: exynos5: Properly use the "noirq" variants of
 suspend/resume
In-Reply-To: <1403714360-7581-1-git-send-email-dianders@chromium.org>
References: <1403714360-7581-1-git-send-email-dianders@chromium.org>
Message-ID: <20140716173035.GE2759@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 09:39:20AM -0700, Doug Anderson wrote:
> The original code for the exynos i2c controller registered for the
> "noirq" variants.  However during review feedback it was moved to
> SIMPLE_DEV_PM_OPS without anyone noticing that it meant we were no
> longer actually "noirq" (despite functions named
> exynos5_i2c_suspend_noirq and exynos5_i2c_resume_noirq).
> 
> i2c controllers that might have wakeup sources on them seem to need to
> resume at noirq time so that the individual drivers can actually read
> the i2c bus to handle their wakeup.
> 
> NOTE: I took the original review feedback from Wolfram and added
> poweroff, thaw, freeze, restore.
> 
> This patch has only been compile-tested since I don't have all the
> patches needed to make my machine using this i2c driver actually
> suspend/resume.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/5d06dde8/attachment.sig>
