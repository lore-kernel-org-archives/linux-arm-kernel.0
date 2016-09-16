From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 16 Sep 2016 11:44:33 +0200
Subject: [PATCH v2] KVM: arm/arm64: Route vtimer events to user space
In-Reply-To: <1474002553-30079-1-git-send-email-agraf@suse.de>
References: <1474002553-30079-1-git-send-email-agraf@suse.de>
Message-ID: <20160916094433.GA4794@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alex,

On Fri, Sep 16, 2016 at 07:09:13AM +0200, Alexander Graf wrote:
> We have 2 modes for dealing with interrupts in the ARM world. We can either
> handle them all using hardware acceleration through the vgic or we can emulate
> a gic in user space and only drive CPU IRQ pins from there.
> 
> Unfortunately, when driving IRQs from user space, we never tell user space
> about timer events that may result in interrupt line state changes, so we
> lose out on timer events if we run with user space gic emulation.
> 
> This patch set fixes that by routing vtimer expiration events to user space.
> With this patch I can successfully run edk2 and Linux with user space gic
> emulation.

I have two versions of v2.  Are there any differences or did it just go
out twice or got duplicated somehow on my end?

Thanks,
-Christoffer
