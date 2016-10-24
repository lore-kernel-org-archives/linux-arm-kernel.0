From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 24 Oct 2016 10:10:37 +0200
Subject: [PATCH] arm/arm64: KVM: Map the BSS at HYP
In-Reply-To: <1476968441-29003-1-git-send-email-marc.zyngier@arm.com>
References: <1476968441-29003-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20161024081037.GG13680@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 02:00:41PM +0100, Marc Zyngier wrote:
> When used with a compiler that doesn't implement "asm goto"
> (such as the AArch64 port of GCC 4.8), jump labels generate a
> memory access to find out about the value of the key (instead
> of just patching the code). The key itself is likely to be
> stored in the BSS.
> 
> This is perfectly fine, except that we don't map the BSS at HYP,
> leading to an exploding kernel at the first access. The obvious
> fix is simply to map the BSS there (which should have been done
> a long while ago, but hey...).
> 
> Reported-by: Eric Auger <eric.auger@redhat.com>
> Tested-by: Eric Auger <eric.auger@redhat.com>
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Acked-by: Christoffer Dall <christoffer.dall@linaro.org>
