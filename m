From: davem@davemloft.net (David Miller)
Date: Wed, 06 Jan 2016 01:32:29 -0500 (EST)
Subject: [PATCH] ARM: net: bpf: fix zero right shift
In-Reply-To: <1452015244-1230-1-git-send-email-rabin@rab.in>
References: <1452015244-1230-1-git-send-email-rabin@rab.in>
Message-ID: <20160106.013229.122000813125865535.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Rabin Vincent <rabin@rab.in>
Date: Tue,  5 Jan 2016 18:34:04 +0100

> The LSR instruction cannot be used to perform a zero right shift since a
> 0 as the immediate value (imm5) in the LSR instruction encoding means
> that a shift of 32 is perfomed.  See DecodeIMMShift() in the ARM ARM.
> 
> Make the JIT skip generation of the LSR if a zero-shift is requested.
> 
> This was found using american fuzzy lop.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Applied, thanks.
