From: linux@roeck-us.net (Guenter Roeck)
Date: Sun, 03 Nov 2013 10:09:16 -0800
Subject: [PATCH 2/3] watchdog: at91sam9_wdt: avoid spurious watchdog reset
 during init
In-Reply-To: <1383501164-8111-3-git-send-email-b.brezillon@overkiz.com>
References: <1383501164-8111-1-git-send-email-b.brezillon@overkiz.com>
 <1383501164-8111-3-git-send-email-b.brezillon@overkiz.com>
Message-ID: <5276914C.3010803@roeck-us.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/03/2013 09:52 AM, Boris BREZILLON wrote:
> Use the min_heartbeat value instead of the calculated heartbeat value for
> the first watchdog reset to avoid spurious watchdog reset.
>
> Resetting the watchdog counter during init might lead to a watchdog fault
> reset because the watchdog counter has to be running for at least
> min_heartbeat.
>
> Resetting the watchdog counter after heartbeat might lead to a watchdog
> timeout reset because the watchdog counter is running for more than
> max_heartbeat time.
>
> Using min_heartbeat instead of heartbeat does not guarantee that the
> watchdog won't trigger a reset, but at least it reduces the chances to be
> in such a case.
>
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
