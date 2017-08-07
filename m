From: marc.zyngier@arm.com (Marc Zyngier)
Date: Mon, 07 Aug 2017 20:07:12 +0100
Subject: [PATCH v2] KVM: arm64: pass vcpu esr_el2 and far_el2 sysre to
 user space
In-Reply-To: <1502133454-5905-1-git-send-email-gengdongjiu@huawei.com>
 (Dongjiu Geng's message of "Tue, 8 Aug 2017 03:17:34 +0800")
References: <1502133454-5905-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <86r2wnxkm7.fsf@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 08 2017 at  3:17:34 am BST, Dongjiu Geng <gengdongjiu@huawei.com> wrote:
> For the firmware-first RAS solution, SEA and SEI is injected
> by the user space, user space needs to know the vcpu's esr_el2 and
> far_el2 value, so add them to sysreg. user space uses
> the IOCTL KVM_GET_ONE_REG can get their value.

Are we playing a game here? Look at my earlier reply: No _EL2 register
will ever be exposed as such to userspace in the context of an EL1 VM.

So if you want that information, extract it, expose what is required,
strictly what is required, and only when it is required.

In the meantime, I'm NAKing this patch, and any patch that will expose
_EL2 registers outside of nested virtualization.

	M.
-- 
Jazz is not dead. It just smells funny.
