From: andy.gross@linaro.org (Andy Gross)
Date: Thu, 31 Mar 2016 13:23:54 -0500
Subject: [PATCH v2 2/3] ata: ahci-platform: Add ports-implemented DT
 bindings.
In-Reply-To: <1459445500-9071-3-git-send-email-srinivas.kandagatla@linaro.org>
References: <1459445500-9071-1-git-send-email-srinivas.kandagatla@linaro.org>
 <1459445500-9071-3-git-send-email-srinivas.kandagatla@linaro.org>
Message-ID: <20160331182354.GB8252@hector.attlocal.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 31, 2016 at 06:31:39PM +0100, Srinivas Kandagatla wrote:
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

Reviewed-by: Andy Gross <andy.gross@linaro.org>
