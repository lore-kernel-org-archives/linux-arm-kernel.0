From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 22 Feb 2018 09:45:07 +0000
Subject: [PATCH v4 35/40] KVM: arm/arm64: Get rid of vgic_elrsr
In-Reply-To: <20180215210332.8648-36-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-36-christoffer.dall@linaro.org>
Message-ID: <86r2pdjr30.wl-marc.zyngier@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Feb 2018 21:03:27 +0000,
Christoffer Dall wrote:
> 
> There is really no need to store the vgic_elrsr on the VGIC data
> structures as the only need we have for the elrsr is to figure out if an
> LR is inactive when we save the VGIC state upon returning from the
> guest.  We can might as well store this in a temporary local variable.
> 
> This also gets rid of the endianness conversion in the VGIC save
> function, which is completely unnecessary and would actually result in
> incorrect functionality on big-endian systems, because we are only using
> typed values here and not converting pointers and reading different
> types here.
> 
> Signed-off-by: Christoffer Dall <christoffer.dall@linaro.org>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.

-- 
Jazz is not dead, it just smell funny.
