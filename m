From: will.deacon@arm.com (Will Deacon)
Date: Tue, 9 Feb 2016 17:20:58 +0000
Subject: [PATCH v4 0/7] arm64: Verify early CPU features
In-Reply-To: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
References: <1453745225-27736-1-git-send-email-suzuki.poulose@arm.com>
Message-ID: <20160209172057.GU22874@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 25, 2016 at 06:06:58PM +0000, Suzuki K Poulose wrote:
> From: Suzuki K. Poulose <suzuki.poulose@arm.com>
> 
> This series adds support for verifying some of the cpufeatures
> that are decided early in the boot process based on the boot
> CPU and cannot be delayed until all the CPUs are up (e.g, ASIDBits
> and may be VHE?). It also adds support for handling the failures
> in booting the secondary CPUs which could not be synchronised
> with the master CPU, otherwise.
> 
> It also adds one of the users of this early hook, check for ASIDBits.
> The mm_context id is based on the ASIDBits width supported by the
> boot CPU and is used early in the initialisation. So we need to make
> sure that all the secondary CPUs supports the width reported by the
> booting CPU, failing which we crash the system.
> 
> This series has been tested on Juno, Fast model by injecting smaller
> ASIDBits, lack of page-size support and missing features(PAN)

Module the comments from Mark and Catalin on patch 4, the rest looks
good to me:

Acked-by: Will Deacon <will.deacon@arm.com>

Will
