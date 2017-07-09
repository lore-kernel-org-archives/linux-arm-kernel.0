From: Chris.Packham@alliedtelesis.co.nz (Chris Packham)
Date: Sun, 9 Jul 2017 21:32:44 +0000
Subject: [PATCH] ARM: mvebu: use __pa_symbol in the mv98dx3236 platform
 SMP code
References: <20170707075928.2938-1-gregory.clement@free-electrons.com>
Message-ID: <1ded3c712b4540eb9903bf9741ed8d6e@svr-chch-ex1.atlnz.lc>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/07/17 19:59, Gregory CLEMENT wrote:
> As we already did for Armada XP switch from virt_to_phys() to
> __pa_symbol().
> 
> The reason for it was well explained by Mark Rutland so let's quote him:
> 
> "virt_to_phys() is intended to operate on the linear/direct mapping of
> RAM.
> 
> __pa_symbol() is intended to operate on the kernel mapping, which may
> not be in the linear/direct mapping on all architectures. e.g. arm64 and
> x86_64 map the kernel image and RAM separately.
> 
> On 32-bit ARM the kernel image mapping is tied to the linear/direct
> mapping, so that works, but as it's semantically wrong (and broken for
> generic code), the DEBUG_VIRTUAL checks complain."
> 
> Fixes: db88977894ab ("arm: mvebu: support for SMP on 98DX3336 SoC")
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Gregory CLEMENT <gregory.clement@free-electrons.com>
> ---
> 
> Hi Chris,
> 
> with this patch I don't expect any regression, hover it would be nice
> if you can test it.

Works for me

Tested-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
