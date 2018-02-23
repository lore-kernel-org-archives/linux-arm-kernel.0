From: julien.grall@arm.com (Julien Grall)
Date: Fri, 23 Feb 2018 14:44:30 +0000
Subject: [PATCH v4 35/40] KVM: arm/arm64: Get rid of vgic_elrsr
In-Reply-To: <20180215210332.8648-36-christoffer.dall@linaro.org>
References: <20180215210332.8648-1-christoffer.dall@linaro.org>
 <20180215210332.8648-36-christoffer.dall@linaro.org>
Message-ID: <b15dda97-a860-0ed5-79d0-4c011f7e3b84@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Christoffer,

On 15/02/18 21:03, Christoffer Dall wrote:
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

I can't find any endianness code removed in this code. What did I miss?

Cheers,

-- 
Julien Grall
