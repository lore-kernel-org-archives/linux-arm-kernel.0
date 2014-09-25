From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 25 Sep 2014 10:52:24 +0100
Subject: [PATCH v2] ARM: mm: clear SCTLR.HA instead of setting it for LPAE
In-Reply-To: <1411580498-17367-1-git-send-email-will.deacon@arm.com>
References: <1411580498-17367-1-git-send-email-will.deacon@arm.com>
Message-ID: <20140925095223.GF10390@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 24, 2014 at 06:41:38PM +0100, Will Deacon wrote:
> SCTLR.HA (hardware access flag) is deprecated and not actually
> implemented by any CPUs. Furthermore, it can confuse cr_alignment checks
> where the whole value of SCTLR is compared against the value sitting in
> the hardware, since the bit is actually RAZ/WI and will not match the
> saved cr_alignment value.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
