From: robh@kernel.org (Rob Herring)
Date: Wed, 9 Aug 2017 18:46:59 -0500
Subject: [PATCH] remoteproc/keystone: Add support for Keystone 66AK2G SOCs
In-Reply-To: <20170731200502.30479-1-s-anna@ti.com>
References: <20170731200502.30479-1-s-anna@ti.com>
Message-ID: <20170809234659.bn63lheilpjqj55o@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 03:05:02PM -0500, Suman Anna wrote:
> Add support to the keystone remoteproc driver for managing the
> DSP present in the Keystone 2 66AK2G SoC. The 66AK2G SoC has
> a Power Management Micro Controller (PMMC) that manages the
> individual device's power, clock and reset functionalities.
> 
> The keystone remoteproc driver already uses standard frameworks
> for reset and clock control, so it doesn't require any significant
> modifications other than a new compatible suitable for 66AK2G DSP.
> 
> The binding document is also updated to reflect the modified
> property values used by the 66AK2G DSP node as compared to the
> values used by existing Keystone 2 DSPs.
> 
> Signed-off-by: Suman Anna <s-anna@ti.com>
> Signed-off-by: Andrew F. Davis <afd@ti.com>
> ---
> Hi Bjorn,
> 
> This patch adds the support to the last remaining family of Keystone2 SoCs.
> The SoC integration is slightly different for this family, and all the
> dependent drivers were finally merged in 4.13-rc1. The patch is mainly
> updating the binding, so didn't split the patch into two.
> 
> regards
> Suman
> 
>  .../bindings/remoteproc/ti,keystone-rproc.txt      | 73 +++++++++++++++++++---
>  drivers/remoteproc/keystone_remoteproc.c           |  1 +
>  2 files changed, 65 insertions(+), 9 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
