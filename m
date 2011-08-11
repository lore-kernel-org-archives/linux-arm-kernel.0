From: swarren@nvidia.com (Stephen Warren)
Date: Thu, 11 Aug 2011 13:54:25 -0700
Subject: [PATCH] i2c: tegra: fix possible race condition after tx
In-Reply-To: <1313093946-24559-1-git-send-email-dianders@chromium.org>
References: <1313093946-24559-1-git-send-email-dianders@chromium.org>
Message-ID: <74CDBE0F657A3D45AFBB94109FB122FF04AEA24CFC@HQMAIL01.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Doug Anderson wrote at Thursday, August 11, 2011 2:19 PM:
> In tegra_i2c_fill_tx_fifo, once we have finished pushing all the bytes
> to the I2C hardware controller, the interrupt might happen before we
> have updated i2c_dev->msg_buf_remaining at the end of the function.
> Then, in tegra_i2c_isr, we will call again tegra_i2c_fill_tx_fifo
> triggering weird behaviour. This has been shown to happen under real
> conditions.
> 
> Signed-off-by: Doug Anderson <dianders@chromium.org>

Acked-by: Stephen Warren <swarren@nvidia.com>

It's worth pointing out that this patch supersedes a previous attempt to fix
the same problem, originally posted in https://lkml.org/lkml/2011/4/19/514,
if I'm understanding correctly.

-- 
nvpublic
