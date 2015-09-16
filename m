From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 16 Sep 2015 15:41:41 +0200
Subject: [PATCH] arm64: KVM: Fix user access for debug registers
In-Reply-To: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
References: <1442400070-23316-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150916134141.GA15903@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 11:41:10AM +0100, Marc Zyngier wrote:
> When setting the debug register from userspace, make sure that
> copy_from_user() is called with its parameters in the expected
> order. It otherwise doesn't do what you think.
> 
> Reported-by: Peter Maydell <peter.maydell@linaro.org>
> Cc: Alex Benn?e <alex.bennee@linaro.org>
> Fixes: 84e690bfbed1 ("KVM: arm64: introduce vcpu->arch.debug_ptr")
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

yikes!

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
