From: will.deacon@arm.com (Will Deacon)
Date: Tue, 16 Jun 2015 15:51:05 +0100
Subject: [PATCH 00/10] arm64: Use BRK instruction for generic BUG traps
In-Reply-To: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
References: <1434036566-9848-1-git-send-email-Dave.Martin@arm.com>
Message-ID: <20150616145105.GG30522@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dave,

On Thu, Jun 11, 2015 at 04:29:14PM +0100, Dave P Martin wrote:
> Currently, the minimal default BUG() implementation from asm-generic is
> used for arm64.
> 
> This series uses the BRK software breakpoint instruction to generate a
> trap instead, similarly to most other arches, with the generic BUG code
> generating the dmesg boilerplate.  This eliminates a fair amount of
> inlined code at BUG() and WARN() sites.

I think patches 3 and 8 are a bit OTT and don't really bring us much.
However, for the rest of the series (modulo my minor comments):

  Reviewed-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
