From: will.deacon@arm.com (Will Deacon)
Date: Thu, 31 Oct 2013 00:23:17 +0000
Subject: [PATCH v3 2/4] AArch64: KGDB: Add Basic KGDB support
In-Reply-To: <1382094469-7971-3-git-send-email-vijay.kilari@gmail.com>
References: <1382094469-7971-1-git-send-email-vijay.kilari@gmail.com>
 <1382094469-7971-3-git-send-email-vijay.kilari@gmail.com>
Message-ID: <20131031002317.GG27743@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 18, 2013 at 12:07:47PM +0100, vijay.kilari at gmail.com wrote:
> From: Vijaya Kumar K <Vijaya.Kumar@caviumnetworks.com>
> 
> Add KGDB debug support for kernel debugging.
> With this patch, basic KGDB debugging is possible.GDB register
> layout is updated and GDB tool can establish connection with
> target and can set/clear breakpoints.

This mostly looks fine to me now. The only remaining concerns I have are
about FP support (currently you just return zeroes for the simd register
file) and the limited BUFMAX definition (the register file with simd is
around 800 bytes afaict, and that's before you add the GDB packet
information and checksums).

What's the plan on sorting those out?

Will
