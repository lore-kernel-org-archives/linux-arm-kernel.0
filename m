From: wsa@the-dreams.de (Wolfram Sang)
Date: Tue, 12 Apr 2016 17:41:00 +0200
Subject: [PATCH 0/6] ARM/ARM64: Drop arm_pm_restart
In-Reply-To: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
References: <1460120039-2497-1-git-send-email-linux@roeck-us.net>
Message-ID: <20160412154059.GB1537@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 08, 2016 at 05:53:53AM -0700, Guenter Roeck wrote:
> This is the final push to replace arm_pm_restart with the kernel restart
> handler. Finally drop arm_pm_restart after it is no longer used.
> The following changes since commit 541d8f4d59d79f5d37c8c726f723d42ff307db57:
> 
> ----------------------------------------------------------------
> Guenter Roeck (6):
>       ARM: prima2: Register with kernel restart handler
>       ARM: xen: Register with kernel restart handler
>       ARM: PSCI: Register with kernel restart handler
>       ARM: Register with kernel restart handler
>       ARM64: Remove arm_pm_restart
>       ARM: Remove arm_pm_restart

I double checked that all arm_pm_restart were converted, did a visual
review of the patches (one nit found), and came to the same conclusions
about the priority settings. Thus:

Reviewed-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

I also added a watchdog restart handler with higher priority than the
PSCI handler. That now works nicely \o/

So, for patches 3+5 you could also add:

Tested-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Thanks,

   Wolfram

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160412/c733d531/attachment.sig>
