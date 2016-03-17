From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 17 Mar 2016 15:34:29 +0000
Subject: [PATCH v4] irqchip/gicv3-its: Don't allow devices whose ID is
 outside range
In-Reply-To: <1458227925-21952-1-git-send-email-shankerd@codeaurora.org>
References: <1458227925-21952-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <56EACE85.4090603@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 17/03/16 15:18, Shanker Donthineni wrote:
> We are not checking whether the requested device identifier fits into
> the device table memory or not. The function its_create_device()
> assumes that enough memory has been allocated for whole DevID space
> (reported by ITS_TYPER.Devbits) during the ITS probe() and continues
> to initialize ITS hardware.
> 
> This assumption is not perfect, sometimes we reduce memory size either
> because of its size crossing MAX_ORDER-1 or BASERn max size limit. The
> MAPD command fails if 'Device ID' is outside of device table range.
> 
> Add a simple validation check to avoid MAPD failures since we are
> not handling ITS command errors. This change also helps to return an
> error -ENOMEM instead of success to caller.
> 
> Signed-off-by: Shanker Donthineni <shankerd@codeaurora.org>

Is there any difference between this patch and the one you posted on
March 10th?

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
