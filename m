From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Oct 2016 15:31:05 +0100
Subject: [PATCH] arm64/kprobes: Tidy up sign-extension usage
In-Reply-To: <f25b75bf250827113d4269614ba7936e870b0646.1476794661.git.robin.murphy@arm.com>
References: <f25b75bf250827113d4269614ba7936e870b0646.1476794661.git.robin.murphy@arm.com>
Message-ID: <20161020143105.GF24914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 18, 2016 at 01:46:27PM +0100, Robin Murphy wrote:
> Kprobes does not need its own homebrewed (and frankly inscrutable) sign
> extension macro; just use the standard kernel functions instead. Since
> the compiler actually recognises the sign-extension idiom of the latter,
> we also get the small bonus of some nicer codegen, as each displacement
> calculation helper then compiles to a single optimal SBFX instruction.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  arch/arm64/kernel/probes/simulate-insn.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)

Acked-by: Will Deacon <will.deacon@arm.com>

Will
