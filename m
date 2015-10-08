From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 15:43:48 +0100
Subject: [PATCH v2 06/22] arm64: sys_reg: Define System register encoding
In-Reply-To: <56155066.9000000@arm.com>
References: <1444064531-25607-1-git-send-email-suzuki.poulose@arm.com>
 <1444064531-25607-7-git-send-email-suzuki.poulose@arm.com>
 <20151007163650.GC17192@e104818-lin.cambridge.arm.com>
 <56155066.9000000@arm.com>
Message-ID: <20151008144348.GJ17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 07, 2015 at 06:03:34PM +0100, Suzuki K. Poulose wrote:
> On 07/10/15 17:36, Catalin Marinas wrote:
> >On Mon, Oct 05, 2015 at 06:01:55PM +0100, Suzuki K. Poulose wrote:
> >>   * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview",
> >>   *  C5.2, version:ARM DDI 0487A.f)
> >>   *	[20-19] : Op0
> >>@@ -34,15 +34,40 @@
> >>   *	[15-12] : CRn
> >>   *	[11-8]  : CRm
> >>   *	[7-5]   : Op2
> >>+ * Hence we use [ sys_reg() << 5 ] in the mrs/msr instructions.
> >
> >Do we really need to have all the ids shifted right by 5? I can't see
> >where it helps. OTOH, it makes the code more complicated by having to
> >remember to shift the id left by 5.
> 
> This is a cosmetic change, to reuse the sys_reg() definitions for both
> mrs_s/msr_s macros and the CPU ID. The (existing)left shift is only needed
> for the mrs_s/msr_s, so the existing users don't have to worry about the shift
> unless they have hard-open-coded values for the register. On the plus
> side it becomes slightly easier to use the same encoding for CPU id
> tracking (and manual decoding). If you think this is superfluous, I could
> change the CPU-id to use right shifted values from sys_reg.

You may be right but I still fail to see whether the shifted values are
useful to the CPUID code. Are you referring to the 'switch' statements?

-- 
Catalin
