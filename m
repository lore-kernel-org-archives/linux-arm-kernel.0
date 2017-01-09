From: javier@osg.samsung.com (Javier Martinez Canillas)
Date: Mon, 9 Jan 2017 12:39:22 -0300
Subject: [PATCH 1/2] usb: host: ehci-exynos: Decrese node refcount on
 exynos_ehci_get_phy() error paths
In-Reply-To: <20170107084141.3731-1-krzk@kernel.org>
References: <20170107084141.3731-1-krzk@kernel.org>
Message-ID: <8a9d9fe4-5f24-e162-0adc-866c8eefd387@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Krzysztof,

On 01/07/2017 05:41 AM, Krzysztof Kozlowski wrote:
> Returning from for_each_available_child_of_node() loop requires cleaning
> up node refcount.  Error paths lacked it so for example in case of
> deferred probe, the refcount of phy node was left increased.
> 
> Fixes: 6d40500ac9b6 ("usb: ehci/ohci-exynos: Fix of_node_put() for child when getting PHYs")
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Javier Martinez Canillas <javier@osg.samsung.com>

Best regards,
-- 
Javier Martinez Canillas
Open Source Group
Samsung Research America
