From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 6 Apr 2016 13:32:13 +0200
Subject: [PATCH] arm64: KVM: Warn when PARange is less than 40 bits
In-Reply-To: <1459869107-6367-1-git-send-email-marc.zyngier@arm.com>
References: <1459869107-6367-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160406113213.GB16355@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 05, 2016 at 04:11:47PM +0100, Marc Zyngier wrote:
> We always thought that 40bits of PA range would be the minimum people
> would actually build. Anything less is terrifyingly small.
> 
> Turns out that we were both right and wrong. Nobody has ever built
> such a system, but the ARM Foundation Model has a PARange set to 36bits.
> Just because we can. Oh well. Now, the KVM API explicitely says that
> we offer a 40bit PA space to the VM, so we shouldn't run KVM on
> the Foundation Model at all.
> 
> That being said, this patch offers a less agressive alternative, and
> loudly warns about the configuration being unsupported. You'll still
> be able to run VMs (at your own risks, though).
> 
> This is just a workaround until we have a proper userspace API where
> we report the PARange to userspace.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
