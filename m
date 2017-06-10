From: santosh.shilimkar@oracle.com (Santosh Shilimkar)
Date: Sat, 10 Jun 2017 12:32:43 -0700
Subject: [PATCH v2 3/3] remoteproc/keystone: Ensure the DSPs are in reset
 in probe
In-Reply-To: <20170608002447.47580-4-s-anna@ti.com>
References: <20170608002447.47580-1-s-anna@ti.com>
 <20170608002447.47580-4-s-anna@ti.com>
Message-ID: <6ce5952b-55b0-8f77-2e14-51110d6bf979@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/7/2017 5:24 PM, Suman Anna wrote:
> From: "Andrew F. Davis" <afd@ti.com>
> 
> The DSPs are expected to be in reset when the driver probes a device.
> If the DSPs are out of reset in probe, the system may crash when the
> firmware is being loaded. So, add a check to make sure the DSP resets
> are asserted, and if not, throw a eye-catchy warning and assert the
> resets specifically.
> 
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> [s-anna at ti.com: replace warning with a WARN]
> Signed-off-by: Suman Anna <s-anna@ti.com>
> ---
Acked-by: Santosh Shilimkar <ssantosh@kernel.org>
