From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 23 Feb 2016 08:51:15 +0000
Subject: [PATCH] irqchip/gicv3-its: Don't allow devices whose ID is
 outside range
In-Reply-To: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
References: <1456199868-9054-1-git-send-email-shankerd@codeaurora.org>
Message-ID: <56CC1D83.4060503@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/16 03:57, Shanker Donthineni wrote:
> We are not checking whether the requested device identifier fits into
> table or not. The ITS MAPD command fails if 'Device ID' is outside of
> device table range.
> 
> Add a simple validation check to avoid MAPD failures since we are
> not handling ITS command errors. This change also helps to return an
> error -ENOMEM instead of success to caller.
> 

In which circumstances do you see this failing? We allocate memory for
the whole DevID range (as advertised by the ITS), so anything that comes
up outside of that range cannot be handled anyway, and is a HW
integration issue. You might as well pretend that these devices do not
exist.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
