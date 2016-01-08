From: will.deacon@arm.com (Will Deacon)
Date: Fri, 8 Jan 2016 15:44:23 +0000
Subject: [PATCH] arm64: net: bpf: don't BUG() on large shifts
In-Reply-To: <1452015543-6790-1-git-send-email-rabin@rab.in>
References: <1452015543-6790-1-git-send-email-rabin@rab.in>
Message-ID: <20160108154423.GC11228@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 06:39:03PM +0100, Rabin Vincent wrote:
> Attempting to generate UBFM/SBFM instructions with shifts that can't be
> encoded in the immediate fields of the opcodes leads to a trigger of a
> BUG() in the instruction generation code.  As the ARMv8 ARM says: "The
> shift amounts must be in the range 0 to one less than the register width
> of the instruction, inclusive."  Make the JIT reject unencodable shifts
> instead of crashing.

I moaned about those BUG_ONs when they were introduced:

  https://lkml.org/lkml/2014/7/17/438

The response then was that the verifier would catch these issues so
there was nothing to worry about. Has something changed so that is no
longer the case? Do we need to consider a different way of rejecting
invalid instructions at the encoding stage rather than bringing down the
kernel?

Will
