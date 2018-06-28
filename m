From: peterz@infradead.org (Peter Zijlstra)
Date: Thu, 28 Jun 2018 10:31:07 +0200
Subject: [PATCH 5/5] x86/kernel: jump_table: use relative references
In-Reply-To: <20180627160604.8154-6-ard.biesheuvel@linaro.org>
References: <20180627160604.8154-1-ard.biesheuvel@linaro.org>
 <20180627160604.8154-6-ard.biesheuvel@linaro.org>
Message-ID: <20180628083107.GY2494@hirez.programming.kicks-ass.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 27, 2018 at 06:06:04PM +0200, Ard Biesheuvel wrote:
> Similar to the arm64 case, 64-bit x86 can benefit from using 32-bit
> relative references rather than 64-bit absolute ones when emitting
> struct jump_entry instances. Not only does this reduce the memory
> footprint of the entries themselves by 50%, it also removes the need
> for carrying relocation metadata on relocatable builds (i.e., for KASLR)
> which saves a fair chunk of .init space as well (although the savings
> are not as dramatic as on arm64)

This will conflict with:

  https://lkml.kernel.org/r/20180622172212.199633-10-namit at vmware.com
