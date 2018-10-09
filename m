From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 9 Oct 2018 01:56:43 -0700
Subject: [PATCH 2/3] mfd: ti-lmu: use managed resource for everything
In-Reply-To: <20180911210344.GB32497@amd>
References: <20180911210133.GA32497@amd>
 <20180911210344.GB32497@amd>
Message-ID: <20181009085643.GB4939@dell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 11 Sep 2018, Pavel Machek wrote:

> This replaces all remaining unmanaged resources with device
> managed ones, so that the remove function is no longer needed.
> This makes the code slightly shorter and fixes two problems:
>     
>  1. The hardware is disabled after the child devices have
>     been removed. Previously there was a potential race
>     condition.
>  2. The hardware is disabled when mfd_add_devices fails
>     during probe.
>     
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.co.uk>
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Applied, thanks.

-- 
Lee Jones [???]
Linaro Services Technical Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
