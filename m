From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 May 2017 16:24:46 +0100
Subject: [PATCH 0/6] arm64: inline assembly fixes + cleanup
In-Reply-To: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
References: <1493824178-7399-1-git-send-email-mark.rutland@arm.com>
Message-ID: <20170509152446.GB25451@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 03, 2017 at 04:09:32PM +0100, Mark Rutland wrote:
> Recent attempts to make our inline assembly more clang-friendly [1,2]
> made it clear that we have some latent problems. I've reviewed all the
> inline assembly under arch/arm64/, and this series fixes the issues that
> I noted.
> 
> The series is based on the arm64 for-next/core branch. I've built the
> series with a Linaro 15,08 GCC 5.1.1 toolchain. I see no new warnings,
> and the result boots happily on Juno R1.
> 
> The first four patches address latent bugs, with the final two patches
> improving consistency and compatibility with clang. I believe that this
> supersedes [2], with the GIC accessor having been fixed up by the recent
> sysreg rework.

For the series:

Acked-by: Will Deacon <will.deacon@arm.com>

It's a pity that we always cast to (unsigned long) for xchg, but I doubt
it actually makes a performance difference in practice.

Will
