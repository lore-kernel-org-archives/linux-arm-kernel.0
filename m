From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 16 May 2018 11:51:44 +0100
Subject: [PATCH] arm64: Select ARCH_HAS_FAST_MULTIPLIER
In-Reply-To: <877b532d8d240c1d9e9db923c84b924443a218ed.1524583390.git.robin.murphy@arm.com>
References: <877b532d8d240c1d9e9db923c84b924443a218ed.1524583390.git.robin.murphy@arm.com>
Message-ID: <20180516105144.yt6kwvxy64hdepsj@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 24, 2018 at 04:25:47PM +0100, Robin Murphy wrote:
> It is probably safe to assume that all Armv8-A implementations have a
> multiplier whose efficiency is comparable or better than a sequence of
> three or so register-dependent arithmetic instructions. Select
> ARCH_HAS_FAST_MULTIPLIER to get ever-so-slightly nicer codegen in the
> few dusty old corners which care.
> 
> In a contrived benchmark calling hweight64() in a loop, this does indeed
> turn out to be a small win overall, with no measurable impact on
> Cortex-A57 but about 5% performance improvement on Cortex-A53.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>

Queued for 4.18. Thanks.

-- 
Catalin
