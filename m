From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 09 Jan 2018 09:13:37 -0800
Subject: [PATCH v2 0/6] ARM branch predictor hardening
In-Reply-To: <20180108185533.9698-1-marc.zyngier@arm.com>
References: <20180108185533.9698-1-marc.zyngier@arm.com>
Message-ID: <BE82ED38-B07B-47AE-8D9D-0320E25F6CCF@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On January 8, 2018 10:55:27 AM PST, Marc Zyngier <marc.zyngier@arm.com> wrote:
>This small series implements some basic BP hardening by invalidating
>the BTB on CPUs that are known to be susceptible to aliasing attacks.
>
>These patches are closely modelled against what we do on arm64,
>although simpler as we can rely on an architected instruction to
>perform the invalidation. The notable exception is Cortex-A15, where
>BTB invalidation behaves like a NOP, and the only way to shoot the
>predictor down is to invalidate the icache *and* to have ACTLR[0] set
>to 1 (which is a secure-only operation).

Is there a publicly available test case/exploit that we could use to regress test this against? I will follow up with the Brahma-B15 patches after you send your v3.

Thanks!
Hi Marc,
-- 
Florian
