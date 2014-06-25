From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 25 Jun 2014 15:31:34 +0200
Subject: [PATCH] arm/arm64: DT: Fix GICv2 CPU interface size
In-Reply-To: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
References: <1403692675-26503-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140625133134.GQ19730@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 25, 2014 at 11:37:54AM +0100, Marc Zyngier wrote:
> All the Cortex-{A7,A15} implementations are using a GICv2. Same for
> the current arm64 platforms.
> 
> Turns out that most of these platforms have described their GIC CPU
> interface size as being 4kB. while it is actually 8kB (the GICC_DIR
> register lives at offset 0x1000).
> 
> This was found when converting the GIC driver to use EOImode==1 on
> GICv2-based systems. It uses the GICC_DIR register, and the result
> is a very early firework...
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>

Just tested this on an Allwinner A31.

Acked-by: Maxime Ripard <maxime.ripard@free-electrons.com>
Tested-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140625/94e1a9ca/attachment.sig>
