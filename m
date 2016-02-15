From: sre@kernel.org (Sebastian Reichel)
Date: Mon, 15 Feb 2016 06:03:09 +0100
Subject: [PATCH] power: collie_battery: hide unused variable
In-Reply-To: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
References: <1453736756-1959377-2-git-send-email-arnd@arndb.de>
Message-ID: <20160215050308.GD28626@earth>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Jan 25, 2016 at 04:45:49PM +0100, Arnd Bergmann wrote:
> The 'wakeup_enabled' variable in this driver is only accessed
> by the optional power management functions and we get a warning
> when they are disabled:
> 
> drivers/power/collie_battery.c:29:12: error: 'wakeup_enabled' defined but not used [-Werror=unused-variable]
> 
> This moves the definition next to the users inside the same #ifdef,
> which avoids the warning.

Thanks, queued.

-- Sebastian
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160215/07779cfd/attachment.sig>
