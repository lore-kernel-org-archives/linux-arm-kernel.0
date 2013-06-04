From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 4 Jun 2013 07:50:52 -0700
Subject: Planning the merge of KVM/arm64
In-Reply-To: <51ADDDAE.4040705@arm.com>
References: <51ADDDAE.4040705@arm.com>
Message-ID: <CAMJs5B_PB1pNVCO_EK7aTghN23L+d0RovAFi7inrVsJb5STWOA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 June 2013 05:29, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Guys,
>
> The KVM/arm64 code is now, as it seems, in good enough shape to be
> merged. I've so far addressed all the comments, and it doesn't seem any
> worse then what is queued for its 32bit counterpart.
>

huh?

> For reference, it is sitting there:
> git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms.git
> kvm-arm64/kvm
>
> What is not defined yet is the merge path:
> - It is touching some of the arm64 core code, so it would be better if
> it was merged through the arm64 tree
> - It is depending on some of the patches in the core KVM queue (the
> vgic/timer move to virt/kvm/arm/)
> - It is also depending on some of the patches that are in the KVM/ARM
> queue (parametrized timer interrupt, some MMU/MMIO fixes)
>
> So I can see two possibilities:
> - Either I can rely on a stable branch from both KVM and KVM/ARM trees
> on which I can base my tree for Catalin/Will to pull,
> - Or I ask Catalin to only pull the arm64 part *minus the Kconfig*, and
> only merge this last bit when the dependencies are satisfied in Linus' tree.
>
> What do you guys think?
>
I would think you would prefer option (1) to get the code in cleaner.
Both the KVM/next tree is stable and I can provide you with a stable
KVM/ARM tree. But I really don't feel strongly about this.

-Christoffer
