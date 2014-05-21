From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 21 May 2014 10:33:44 +0200
Subject: [PATCH] i2c: nomadik: Fixup system suspend
In-Reply-To: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
References: <1397138376-28427-1-git-send-email-ulf.hansson@linaro.org>
Message-ID: <20140521083344.GH2708@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 10, 2014 at 03:59:36PM +0200, Ulf Hansson wrote:
> For !CONFIG_PM_RUNTIME, the device were never put back into active
> state while resuming.
> 
> For CONFIG_PM_RUNTIME, we blindly trusted the device to be inactive
> while we were about to handle it at suspend late, which is just too
> optimistic.
> 
> Even if the driver uses pm_runtime_put_sync() after each tranfer to
> return it's runtime PM resources, there are no guarantees this will
> actually mean the device will inactivated. The reason is that the PM
> core will prevent runtime suspend during system suspend, and thus when
> a transfer occurs during the early phases of system suspend the device
> will be kept active after the transfer.
> 
> To handle both issues above, use pm_runtime_force_suspend|resume() from
> the system suspend|resume callbacks.
> 
> Cc: Alessandro Rubini <rubini@unipv.it>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Wolfram Sang <wsa@the-dreams.de>
> Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>

Applied to for-next, thanks!

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140521/f8b2b043/attachment.sig>
