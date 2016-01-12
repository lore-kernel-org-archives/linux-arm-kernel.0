From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Tue, 12 Jan 2016 11:26:21 -0800
Subject: [PATCHv2] net: bpf: reject invalid shifts
In-Reply-To: <1452626228-15742-1-git-send-email-rabin@rab.in>
References: <20160112185121.GA34045@ast-mbp.thefacebook.com>
 <1452626228-15742-1-git-send-email-rabin@rab.in>
Message-ID: <20160112192620.GB34276@ast-mbp.thefacebook.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 12, 2016 at 08:17:08PM +0100, Rabin Vincent wrote:
> On ARM64, a BUG() is triggered in the eBPF JIT if a filter with a
> constant shift that can't be encoded in the immediate field of the
> UBFM/SBFM instructions is passed to the JIT.  Since these shifts
> amounts, which are negative or >= regsize, are invalid, reject them in
> the eBPF verifier and the classic BPF filter checker, for all
> architectures.
> 
> Signed-off-by: Rabin Vincent <rabin@rab.in>
> ---
> v2: handle BPF_ARSH too

Thanks.
Acked-by: Alexei Starovoitov <ast@kernel.org>
