From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 30 Aug 2016 09:50:24 +0100
Subject: [PATCH] generic: Add the exception case checking routine for ppi
 interrupt
In-Reply-To: <1472530639-21616-1-git-send-email-majun258@huawei.com>
References: <1472530639-21616-1-git-send-email-majun258@huawei.com>
Message-ID: <57C548D0.3090700@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 30/08/16 05:17, MaJun wrote:
> From: Ma Jun <majun258@huawei.com>
> 
> During system booting, if the interrupt which has no action registered
> is triggered, it would cause system panic when try to access the
> action member.

And why would that interrupt be enabled? If you enable a PPI before
registering a handler, you're doing something wrong.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
