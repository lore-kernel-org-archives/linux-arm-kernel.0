From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 8 Feb 2016 14:44:31 +0000
Subject: [PATCH v3 19/23] arm64: KVM: Move most of the fault decoding to C
In-Reply-To: <1454522416-6874-20-git-send-email-marc.zyngier@arm.com>
References: <1454522416-6874-1-git-send-email-marc.zyngier@arm.com>
 <1454522416-6874-20-git-send-email-marc.zyngier@arm.com>
Message-ID: <20160208144430.GO6076@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 03, 2016 at 06:00:12PM +0000, Marc Zyngier wrote:
> The fault decoding process (including computing the IPA in the case
> of a permission fault) would be much better done in C code, as we
> have a reasonable infrastructure to deal with the VHE/non-VHE
> differences.
> 
> Let's move the whole thing to C, including the workaround for
> erratum 834220, and just patch the odd ESR_EL2 access remaining
> in hyp-entry.S.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Catalin Marinas <catalin.marinas@arm.com>
