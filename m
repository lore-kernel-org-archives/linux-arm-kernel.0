From: marc.zyngier@arm.com (Marc Zyngier)
Date: Tue, 22 Sep 2015 17:50:40 +0100
Subject: [PATCH v5 2/6] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <1442869119-1814-3-git-send-email-rric@kernel.org>
References: <1442869119-1814-1-git-send-email-rric@kernel.org>
 <1442869119-1814-3-git-send-email-rric@kernel.org>
Message-ID: <20150922175040.7288b247@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 21 Sep 2015 22:58:35 +0200
Robert Richter <rric@kernel.org> wrote:

> From: Robert Richter <rrichter@cavium.com>
> 
> This patch implements Cavium ThunderX erratum 23154.
> 
> The gicv3 of ThunderX requires a modified version for reading the IAR
> status to ensure data synchronization. Since this is in the fast-path
> and called with each interrupt, runtime patching is used using jump
> label patching for smallest overhead (no-op). This is the same
> technique as used for tracepoints.
> 
> v5:
>  * fixed calling gic_read_iar_cavium_thunderx() if jump label is
>    enabled
>  * made is_cavium_thunderx static
>  * removed ARCH_THUNDER dependency for Cavium errata options to
>    make it available for generic kernels
> 
> v4:
>  * simplify code to only use cpus_have_cap() in gicv3_enable_quirks()
> 
> v3:
>  * fix erratum to be dependend from midr
>  * use arm64 errata framework
> 
> v2:
>  * implement code in a single asm() to keep instruction sequence
>  * added comment to the code that explains the erratum
>  * apply workaround also if running as guest, thus check MIDR
> 
> Signed-off-by: Robert Richter <rrichter@cavium.com>

Reviewed-by: Marc Zyngier <marc.zyngier@arm.com>

	M.
-- 
Jazz is not dead. It just smells funny.
