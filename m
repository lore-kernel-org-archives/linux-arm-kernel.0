From: nm@ti.com (Nishanth Menon)
Date: Wed, 10 Jan 2018 10:50:52 -0600
Subject: [PATCH v2 0/6] ARM branch predictor hardening
In-Reply-To: <20180108185533.9698-1-marc.zyngier@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
Message-ID: <6e1e34e2-f28f-0a8b-d2c0-f65f7858dac2@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/08/2018 12:55 PM, Marc Zyngier wrote:
> This small series implements some basic BP hardening by invalidating
> the BTB on CPUs that are known to be susceptible to aliasing attacks.
> 
> These patches are closely modelled against what we do on arm64,
> although simpler as we can rely on an architected instruction to
> perform the invalidation. The notable exception is Cortex-A15, where
> BTB invalidation behaves like a NOP, and the only way to shoot the
> predictor down is to invalidate the icache *and* to have ACTLR[0] set
> to 1 (which is a secure-only operation).
> 


btw, just wanted to understand if we had any reasons as to why 
we'arent tagging these for stable? Yes, I am aware of Greg's comments 
in [1], but the v7 series impacts a heck of a lot of existing products 
and is not that extensive to cause too much of a pain is it?

OR, am I missing some thing else?

[1] http://www.kroah.com/log/blog/2018/01/06/meltdown-status/

-- 
Regards,
Nishanth Menon
