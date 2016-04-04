From: robh@kernel.org (Rob Herring)
Date: Mon, 4 Apr 2016 00:15:56 -0500
Subject: [PATCH v3 2/3] ata: ahci-platform: Add ports-implemented DT
 bindings.
In-Reply-To: <1459497178-31090-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459497178-31090-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459497178-31090-3-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160404051556.GH17806@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 01, 2016 at 08:52:57AM +0100, Srinivas Kandagatla wrote:
> On some SOCs PORTS_IMPL register value is never programmed by the
> firmware and left at zero value. Which means that no sata ports are
> available for software. AHCI driver used to cope up with this by
> fabricating the port_map if the PORTS_IMPL register is read zero,
> but recent patch broke this workaround as zero value was valid for
> NVMe disks.
> 
> This patch adds ports-implemented DT bindings as workaround for this issue
> in a way that DT can can override the PORTS_IMPL register in cases where
> the firmware did not program it already.
> 
> Fixes: 566d1827df2e ("libata: disable forced PORTS_IMPL for >= AHCI 1.3)
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> Acked-by: Tejun Heo <tj@kernel.org>
> Reviewed-by: Andy Gross <andy.gross@linaro.org>
> ---
>  Documentation/devicetree/bindings/ata/ahci-platform.txt | 4 ++++
>  drivers/ata/ahci_platform.c                             | 3 +++
>  2 files changed, 7 insertions(+)

Acked-by: Rob Herring <robh@kernel.org>
