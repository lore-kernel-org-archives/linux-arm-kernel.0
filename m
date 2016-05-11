From: pbonzini@redhat.com (Paolo Bonzini)
Date: Wed, 11 May 2016 17:23:30 +0200
Subject: [PULL 00/29] KVM/ARM Changes for v4.7
In-Reply-To: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
References: <1462973422-10021-1-git-send-email-christoffer.dall@linaro.org>
Message-ID: <57334E72.9010109@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 11/05/2016 15:29, Christoffer Dall wrote:
> Hi Paolo and Radim,
> 
> Here is the initial set of changes for KVM/ARM for v4.7.
> 
> Sorry I'm a bit late with these, but we were trying to get the new vgic
> implementation in as part of this, but I have decided to send this pull
> request now, and we can follow up with another for the new VGIC,
> assuming we feel like we have that in place in a few days.

Don't worry, you're not late at all.  I've pulled this to kvm/queue.

> There are a few changes in this pull request touching things outside
> KVM, but they should all carry the necessary acks and it made the
> merge process much easier to do it this way.

The following are properly acked:

    arm64: Reuse TCR field definitions for EL1 and EL2
    arm64: Introduce pmd_thp_or_huge

I wouldn't have minded more explicit Acked-bys for the following:

    irqchip/gic-v2: Gather ACPI specific data in a single structure
    irqchip/gic-v2: Parse and export virtual GIC information
    irqchip/gic-v3: Prefix all pr_* messages by "GICv3: "
    irqchip/gic-v3: Gather all ACPI specific data in a single structure
    irqchip/gic-v3: Parse and export virtual GIC information

I guess it's fine since Marc Zyngier is maintainer for both KVM and
irqchip, still it's never wrong to get more acks. :)

Thanks,

Paolo

> Hope this works for you guys.
> 
> For a description of the content, see below; otherwise:
> 
> The following changes since commit 06a71a24bae57a07afee9cda6b00495347d8a448:
> 
>   arm64: KVM: unregister notifiers in hyp mode teardown path (2016-04-06 13:47:52 +0200)
> 
> are available in the git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/kvmarm/kvmarm.git tags/kvm-arm-for-4.7
> 
> for you to fetch changes up to 06485053244480f5f403d8f89b8617bd7d549113:
> 
>   kvm: arm64: Enable hardware updates of the Access Flag for Stage 2 page tables (2016-05-09 22:23:08 +0200)
