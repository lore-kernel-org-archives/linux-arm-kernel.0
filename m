From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Sat, 7 Jan 2017 10:56:16 +0200
Subject: [PATCH v11 4/8] usb: core: add power sequence handling for USB
 devices
In-Reply-To: <1483596119-27508-5-git-send-email-peter.chen@nxp.com>
References: <1483596119-27508-1-git-send-email-peter.chen@nxp.com>
 <1483596119-27508-5-git-send-email-peter.chen@nxp.com>
Message-ID: <20170107085616.jvercrfl3huzubkr@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 05, 2017 at 02:01:55PM +0800, Peter Chen wrote:
> Some hard-wired USB devices need to do power sequence to let the
> device work normally, the typical power sequence like: enable USB
> PHY clock, toggle reset pin, etc. But current Linux USB driver
> lacks of such code to do it, it may cause some hard-wired USB devices
> works abnormal or can't be recognized by controller at all.
> 
> In this patch, it calls power sequence library APIs to finish
> the power sequence events. It will do power on sequence at hub's
> probe for all devices under this hub (includes root hub).
> At hub_disconnect, it will do power off sequence which is at powered
> on list.
> 
> Signed-off-by: Peter Chen <peter.chen@nxp.com>
> Tested-by Joshua Clayton <stillcompiling@gmail.com>
> Tested-by: Maciej S. Szmigiero <mail@maciej.szmigiero.name>
> Reviewed-by: Vaibhav Hiremath <hvaibhav.linux@gmail.com>
> ---
>  drivers/usb/Kconfig    |  1 +
>  drivers/usb/core/hub.c | 48 ++++++++++++++++++++++++++++++++++++++++++++----
>  drivers/usb/core/hub.h |  1 +
>  3 files changed, 46 insertions(+), 4 deletions(-)
> 

Acked-by: Krzysztof Kozlowski <krzk@kernel.org>
Tested on Odroid U3 (reset sequence for LAN9730):
Tested-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
