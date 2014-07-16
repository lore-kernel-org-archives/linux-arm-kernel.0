From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 16 Jul 2014 19:35:28 +0200
Subject: [PATCH v2] i2c: s3c2410: resume the I2C controller earlier
In-Reply-To: <1403654214-25072-1-git-send-email-dianders@chromium.org>
References: <1403654214-25072-1-git-send-email-dianders@chromium.org>
Message-ID: <20140716173528.GF2759@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 24, 2014 at 04:56:54PM -0700, Doug Anderson wrote:
> From: Vincent Palatin <vpalatin@chromium.org>
> 
> When the wake-up is triggered by the PMIC RTC, the RTC driver is trying
> to read the PMIC interrupt status over I2C and fails because the I2C
> controller is not resumed yet.
> Let's resume the I2C controller earlier in the _noirq phase
> (as other hardwares are doing), so we can properly get the wake-up
> condition.
> 
> Signed-off-by: Vincent Palatin <vpalatin@chromium.org>
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Applied to for-current (because Tomasz said it fixes issues), thanks! If
you think the exynos patch of the same style should also be in current,
please let me know...

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140716/b9b2ce89/attachment.sig>
