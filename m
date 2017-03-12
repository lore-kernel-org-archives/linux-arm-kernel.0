From: santosh.shilimkar@oracle.com (santosh.shilimkar at oracle.com)
Date: Sun, 12 Mar 2017 10:20:51 -0700
Subject: [PATCH v4 4/5] soc: ti: Add ti_sci_pm_domains driver
In-Reply-To: <1488882154-21485-5-git-send-email-d-gerlach@ti.com>
References: <1488882154-21485-1-git-send-email-d-gerlach@ti.com>
 <1488882154-21485-5-git-send-email-d-gerlach@ti.com>
Message-ID: <00909b96-8cb1-2c57-6072-f899dae3dcad@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/7/17 2:22 AM, Dave Gerlach wrote:
> Introduce a ti_sci_pm_domains driver to act as a generic pm domain
> provider to allow each device to attach and associate it's ti-sci-id so
> that it can be controlled through the TI SCI protocol.
>
> This driver implements a simple genpd where each device node has a
> phandle to the power domain node and also must provide an index which
> represents the ID to be passed with TI SCI representing the device using
> a single phandle cell. The driver manually parses the phandle to get the
> cell value. Through this interface the genpd dev_ops start and stop
> hooks will use TI SCI to turn on and off each device as determined by
> pm_runtime usage.
>
> Signed-off-by: Keerthy <j-keerthy@ti.com>
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Signed-off-by: Dave Gerlach <d-gerlach@ti.com>
> ---
> v3->v4:
>  Parse phandle directly instead of reading ti,sci-id property per device.

Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
