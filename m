From: sre@kernel.org (Sebastian Reichel)
Date: Thu, 3 Mar 2016 15:23:23 +0100
Subject: [PATCH 03/14] power: ipaq-micro-battery: use __maybe_unused to
 hide pm functions
In-Reply-To: <1456934350-1389172-4-git-send-email-arnd@arndb.de>
References: <1456934350-1389172-1-git-send-email-arnd@arndb.de>
 <1456934350-1389172-4-git-send-email-arnd@arndb.de>
Message-ID: <20160303142323.GF29689@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, Mar 02, 2016 at 04:58:55PM +0100, Arnd Bergmann wrote:
> The ipaq micro battery driver has suspend/resume functions that
> are accessed using SIMPLE_DEV_PM_OPS, which hide the reference
> when CONFIG_PM_SLEEP is not set, resulting in a warning about
> unused functions:
> 
> drivers/power/ipaq_micro_battery.c:284:12: error: 'micro_batt_suspend' defined but not used [-Werror=unused-function]
> drivers/power/ipaq_micro_battery.c:292:12: error: 'micro_batt_resume' defined but not used [-Werror=unused-function]
> 
> This adds __maybe_unused annotations to let the compiler know
> it can silently drop the function definition.

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160303/8c3013dc/attachment.sig>
