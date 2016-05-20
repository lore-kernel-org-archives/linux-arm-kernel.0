From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Fri, 20 May 2016 17:04:25 +0200
Subject: [PATCH v5 00/57] KVM: arm/arm64: Rework virtual GIC emulation
In-Reply-To: <1463681316-23039-1-git-send-email-andre.przywara@arm.com>
References: <1463681316-23039-1-git-send-email-andre.przywara@arm.com>
Message-ID: <20160520150425.GC10370@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 19, 2016 at 07:07:39PM +0100, Andre Przywara wrote:
> Hi,
> 
> hopefully the final version of the new VGIC series.
> Again mostly smaller fixes: A new patch (8/57) to establish the
> arch timer <-> VGIC connection later in the init process, to avoid
> calls to VGIC code before the VGIC is actually initialized.
> Also we now make sure that no VCPU is running while userland accesses
> the VGIC registers. The set-active-bit code has been slightly adjusted
> to cover a corner case as well. Last, but not least we now properly
> annotate our lock nesting so the kernel is happy now even with
> CONFIG_SPINLOCK_DEBUG enabled.
> More detailed changelog in the patches.
> 
> As this new VGIC emulation will probably become the default very shortly,
> please test it full steam on whatever setup you have access to.
> Any reports are warmly welcome.
> 
> As v4, this series is based on kvmarm/next, which will be merged
> shortly into Linus' kernel.
> A git tree containing this series can be found on linux-arm.org:
> 
> git://linux-arm.org/linux-ap.git	branch: vgic-new/v5
> http://www.linux-arm.org/git?p=linux-ap.git;a=log;h=refs/heads/vgic-new/v5
> 

Applied, huge thanks for all this work to all participants!

-Christoffer
