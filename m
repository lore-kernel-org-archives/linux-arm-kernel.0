From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 6 Feb 2014 11:56:47 +0000
Subject: [PATCH 6/6] arm64: barriers: use barrier() instead of smp_mb()
 when !SMP
In-Reply-To: <1391686253-13436-6-git-send-email-will.deacon@arm.com>
References: <1391686253-13436-1-git-send-email-will.deacon@arm.com>
 <1391686253-13436-6-git-send-email-will.deacon@arm.com>
Message-ID: <20140206115646.GP29446@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 06, 2014 at 11:30:53AM +0000, Will Deacon wrote:
> The recently introduced acquire/release accessors refer to smp_mb()
> in the !CONFIG_SMP case. This is confusing when reading the code, so use
> barrier() directly when we know we're UP.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
