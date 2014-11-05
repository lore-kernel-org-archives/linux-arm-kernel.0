From: will.deacon@arm.com (Will Deacon)
Date: Wed, 5 Nov 2014 16:19:02 +0000
Subject: [PATCHv3 2/5] arm64: Add AArch32 instruction set condition code
 checks
In-Reply-To: <20141105161454.GM32700@e104818-lin.cambridge.arm.com>
References: <1414435207-30240-1-git-send-email-punit.agrawal@arm.com>
 <1414435207-30240-4-git-send-email-punit.agrawal@arm.com>
 <20141029152148.GM27405@n2100.arm.linux.org.uk>
 <20141105161454.GM32700@e104818-lin.cambridge.arm.com>
Message-ID: <20141105161902.GH22436@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 05, 2014 at 04:14:54PM +0000, Catalin Marinas wrote:
> Anyway, since you mention testing, I wonder how regularly SWP emulation
> gets tested on arm32 (and in future arm64). If Punit has some tests
> already, it may be good to add them somewhere like
> tools/testing/selftests/arm/ (probably separately from this series).

Sounds like you want atomic.h implemented using SWP and CP15 barriers ;)

There *is* lib/atomic64_test.c but, perversely, it's single-threaded and
unlikely to spot issues even if we got it running in userspace.

Will
