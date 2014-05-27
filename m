From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Tue, 27 May 2014 16:02:47 +0200
Subject: [RESEND PATCH v6 7/7] arm64: KVM: Implement 4 levels of
 translation tables for HYP and stage2
In-Reply-To: <000001cf6dc8$60eaa170$22bfe450$@samsung.com>
References: <000001cf6dc8$60eaa170$22bfe450$@samsung.com>
Message-ID: <20140527140247.GK31431@lvm>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 12, 2014 at 06:56:00PM +0900, Jungseok Lee wrote:
> This patch adds 4 levels of translation tables implementation for both
> HYP and stage2.
> 
> Both symmetric and asymmetric configurations for page size and translation
> levels are are validated on Fast Models:
> 
>  1) 4KB  + 3 levels guest on 4KB  + 4 levels host
>  2) 4KB  + 4 levels guest on 4KB  + 4 levels host
>  3) 64KB + 2 levels guest on 4KB  + 4 levels host
>  4) 4KB  + 3 levels guest on 64KB + 2 levels host
>  5) 4KB  + 4 levels guest on 64KB + 2 levels host
>  6) 64KB + 2 levels guest on 64KB + 2 levels host
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Signed-off-by: Jungseok Lee <jays.lee@samsung.com>
> Reviewed-by: Sungjinn Chung <sungjinn.chung@samsung.com>
> Acked-by: Kukjin Kim <kgene.kim@samsung.com>

I'm going to hold off giving this a final review until we have that
previous VTTBR_X patch sorted out.

Given the number of open questions in that one, I recommend you factor
that patch out of this patch set, get that sorted out first, and then
send a new version of this patch set once we have an agreement on the
other patch.

-Christoffer
