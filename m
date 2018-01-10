From: nm@ti.com (Nishanth Menon)
Date: Wed, 10 Jan 2018 16:59:15 -0600
Subject: [PATCH v2 0/6] ARM branch predictor hardening
In-Reply-To: <20180108185533.9698-1-marc.zyngier@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
Message-ID: <381ab8ef-15db-5018-74ec-74d65cfb6883@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2018 12:55 PM, Marc Zyngier wrote:
[...]
> These patches are closely modelled against what we do on arm64,
> although simpler as we can rely on an architected instruction to
> perform the invalidation. The notable exception is Cortex-A15, where
> BTB invalidation behaves like a NOP, and the only way to shoot the
> predictor down is to invalidate the icache *and* to have ACTLR[0] set
> to 1 (which is a secure-only operation).

On u-boot side, we'd probably have to work off ->
http://git.denx.de/?p=u-boot.git;a=commitdiff;h=a615d0be6a73fc48a22e5662608260fe9b9149ff


[...]

-- 
Regards,
Nishanth Menon
