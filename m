From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sun, 25 May 2014 16:34:21 +0100
Subject: [PATCH v2 0/9] arm64: KVM: debug infrastructure support
In-Reply-To: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
References: <1400604945-25247-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140525153421.GA3866@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 20, 2014 at 05:55:36PM +0100, Marc Zyngier wrote:
> This patch series adds debug support, a key feature missing from the
> KVM/arm64 port.
> 
> The main idea is to keep track of whether the debug registers are
> "dirty" (changed by the guest) or not. In this case, perform the usual
> save/restore dance, for one run only. It means we only have a penalty
> if a guest is actively using the debug registers.
> 
> The amount of registers is properly frightening, but CPUs actually
> only implement a subset of them. Also, there is a number of registers
> we don't bother emulating (things having to do with external debug and
> OSlock).

What is the rationale about not having to deal with external debug and
OSlock?

-Christoffer
