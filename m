From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 29 Nov 2011 17:35:37 +0000
Subject: [PATCH] ARM: errata: Remove SMP dependency for erratum 751472
In-Reply-To: <1322586763-12791-1-git-send-email-dave.martin@linaro.org>
References: <1322586763-12791-1-git-send-email-dave.martin@linaro.org>
Message-ID: <20111129173537.GJ9581@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 29, 2011 at 05:12:43PM +0000, Dave Martin wrote:
> -	cmp	r6, #0x30			@ present prior to r3p0
> +	ALT_UP_B(1f)
> +	ALT_SMP(cmp r6, #0x30)			@ present prior to r3p0

Why not look at the definition of these before you (ab)use them?
