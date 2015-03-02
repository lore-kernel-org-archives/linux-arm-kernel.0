From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 2 Mar 2015 10:44:15 +0000
Subject: [Question] How can we support outer shareable on ARM64?
In-Reply-To: <54F41904.90303@huawei.com>
References: <54F41904.90303@huawei.com>
Message-ID: <20150302104414.GC22541@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 02, 2015 at 04:02:12PM +0800, leizhen wrote:
> Now, both cacheable memory shareability attribute and barrier are
> fixed to inner shareable.

That's correct for memory attributes. As for barriers, the mb()
generates full system DSB.

> But I afraid some hardware need outer shareable.

Why? All processors or devices controlled by an operating system are
expected to be in the same inner shareable domain (see shareable memory
in B2.8.1 in the ARMv8 ARM).

-- 
Catalin
