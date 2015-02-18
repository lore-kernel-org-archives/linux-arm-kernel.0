From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 18 Feb 2015 16:08:12 +0000
Subject: [PATCH] arm64: insn: fix compare-and-branch encodings
In-Reply-To: <369053df4298c754061e47068834bd9640b0841b.1424273599.git.robin.murphy@arm.com>
References: <369053df4298c754061e47068834bd9640b0841b.1424273599.git.robin.murphy@arm.com>
Message-ID: <54E4B8EC.7090709@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Oops, missed some CCs...

On 18/02/15 15:40, Robin Murphy wrote:
> Fix cbz/cbnz having the mask offset by a bit, and add encodings for
> tbz/tbnz so that all branch forms are represented.
>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> Acked-by: Will Deacon <will.deacon@arm.com>
> ---
>   arch/arm64/include/asm/insn.h | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/arm64/include/asm/insn.h b/arch/arm64/include/asm/insn.h
> index e2ff32a..d2f4942 100644
> --- a/arch/arm64/include/asm/insn.h
> +++ b/arch/arm64/include/asm/insn.h
> @@ -264,8 +264,10 @@ __AARCH64_INSN_FUNCS(ands,	0x7F200000, 0x6A000000)
>   __AARCH64_INSN_FUNCS(bics,	0x7F200000, 0x6A200000)
>   __AARCH64_INSN_FUNCS(b,		0xFC000000, 0x14000000)
>   __AARCH64_INSN_FUNCS(bl,	0xFC000000, 0x94000000)
> -__AARCH64_INSN_FUNCS(cbz,	0xFE000000, 0x34000000)
> -__AARCH64_INSN_FUNCS(cbnz,	0xFE000000, 0x35000000)
> +__AARCH64_INSN_FUNCS(cbz,	0x7F000000, 0x34000000)
> +__AARCH64_INSN_FUNCS(cbnz,	0x7F000000, 0x35000000)
> +__AARCH64_INSN_FUNCS(tbz,	0x7F000000, 0x36000000)
> +__AARCH64_INSN_FUNCS(tbnz,	0x7F000000, 0x37000000)
>   __AARCH64_INSN_FUNCS(bcond,	0xFF000010, 0x54000000)
>   __AARCH64_INSN_FUNCS(svc,	0xFFE0001F, 0xD4000001)
>   __AARCH64_INSN_FUNCS(hvc,	0xFFE0001F, 0xD4000002)
>
