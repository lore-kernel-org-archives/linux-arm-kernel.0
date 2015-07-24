From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 24 Jul 2015 16:08:51 +0100
Subject: [PATCH v2 09/20] arm64: locks: patch in lse instructions when
 supported by the CPU
In-Reply-To: <1437734531-10698-10-git-send-email-will.deacon@arm.com>
References: <1437734531-10698-1-git-send-email-will.deacon@arm.com>
 <1437734531-10698-10-git-send-email-will.deacon@arm.com>
Message-ID: <20150724150851.GJ3550@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 24, 2015 at 11:42:00AM +0100, Will Deacon wrote:
> On CPUs which support the LSE atomic instructions introduced in ARMv8.1,
> it makes sense to use them in preference to ll/sc sequences.
> 
> This patch introduces runtime patching of our locking functions so that
> LSE atomic instructions are used for spinlocks and rwlocks.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
