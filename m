From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Sat, 18 Jul 2015 00:15:27 +0200
Subject: [PATCH v2 02/10] arm/arm64: KVM: Move vgic handling to a
 non-preemptible section
In-Reply-To: <1436378202-20224-3-git-send-email-marc.zyngier@arm.com>
References: <1436378202-20224-1-git-send-email-marc.zyngier@arm.com>
 <1436378202-20224-3-git-send-email-marc.zyngier@arm.com>
Message-ID: <20150717221527.GI14024@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 08, 2015 at 06:56:34PM +0100, Marc Zyngier wrote:
> As we're about to introduce some serious GIC-poking to the vgic code,
> it is important to make sure that we're going to poke the part of
> the GIC that belongs to the CPU we're about to run on (otherwise,
> we'd end up with some unexpected interrupts firing)...
> 
> Introducing a non-preemptible section in kvm_arch_vcpu_ioctl_run
> prevents the problem from occuring.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> Reviewed-by: Alex Benn?e <alex.bennee@linaro.org>

Reviewed-by: Christoffer Dall <christoffer.dall@linaro.org>
