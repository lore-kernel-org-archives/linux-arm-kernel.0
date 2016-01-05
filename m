From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 5 Jan 2016 09:50:39 -0800
Subject: [PATCH] ARM: net: bpf: fix zero right shift
In-Reply-To: <1452015244-1230-1-git-send-email-rabin@rab.in>
References: <1452015244-1230-1-git-send-email-rabin@rab.in>
Message-ID: <20160105175038.GB83548@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 06:34:04PM +0100, Rabin Vincent wrote:
> The LSR instruction cannot be used to perform a zero right shift since a
> 0 as the immediate value (imm5) in the LSR instruction encoding means
> that a shift of 32 is perfomed.  See DecodeIMMShift() in the ARM ARM.
> 
> Make the JIT skip generation of the LSR if a zero-shift is requested.
> 
> This was found using american fuzzy lop.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>

Looks good as a fix for classic jit. For eBPF we would want to check
this in verifier.

Acked-by: Alexei Starovoitov <ast@kernel.org>
