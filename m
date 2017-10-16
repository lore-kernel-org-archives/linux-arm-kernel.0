From: a.hajda@samsung.com (Andrzej Hajda)
Date: Mon, 16 Oct 2017 12:44:09 +0200
Subject: [RESEND PATCH v2 4/5] drm/bridge/analogix: Do not use device's
 drvdata
In-Reply-To: <20171016100640.26575-5-jeffy.chen@rock-chips.com>
References: <20171016100640.26575-1-jeffy.chen@rock-chips.com>
 <CGME20171016100746epcas2p436f3573bcb862275aea1869aabe4ad17@epcas2p4.samsung.com>
 <20171016100640.26575-5-jeffy.chen@rock-chips.com>
Message-ID: <be199812-9fc5-11ec-cca4-5b9fcff57070@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16.10.2017 12:06, Jeffy Chen wrote:
> From: Tomasz Figa <tfiga@chromium.org>
>
> The driver that instantiates the bridge should own the drvdata, as all
> driver model callbacks (probe, remove, shutdown, PM ops, etc.) are also
> owned by its driver struct. Moreover, storing two different pointer
> types in driver data depending on driver initialization status is barely
> a good practice and in fact has led to many bugs in this driver.
>
> Let's clean up this mess and change Analogix entry points to simply
> accept some opaque struct pointer, adjusting their users at the same
> time to avoid breaking the compilation.
>
> Signed-off-by: Tomasz Figa <tfiga@chromium.org>
> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>

Thanks for making it a bit saner.

Reviewed-by: Andrzej Hajda <a.hajda@samsung.com>

?--
Regards
Andrzej
