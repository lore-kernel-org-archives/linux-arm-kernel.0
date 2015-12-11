From: will.deacon@arm.com (Will Deacon)
Date: Fri, 11 Dec 2015 09:59:46 +0000
Subject: Commit 81a43adae3b9 (locking/mutex: Use acquire/release
 semantics) causing failures on arm64 (ThunderX)
In-Reply-To: <5669D5F2.5050004@caviumnetworks.com>
References: <5669D5F2.5050004@caviumnetworks.com>
Message-ID: <20151211095946.GC18828@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 10, 2015 at 11:43:46AM -0800, David Daney wrote:
> We are getting soft lockup OOPs on Cavium CN88XX (A.K.A. ThunderX), which is
> an arm64 implementation.

[...]

> At this point it is unknown if this patch is incorrect, or if the underlying
> ARM64 atomic_*_{acquire,release} primitives are defective, or if the problem
> lies elsewhere.

Are you using the ll/sc or lse versions of the atomics? In the case of
the former, are they inline or out-of-line (this depends on whether or
not you've selected CONFIG_ARM64_LSE_ATOMICS and whether or not you have
toolchain support)?

Will
