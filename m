From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 22 Jun 2011 15:54:52 +0100
Subject: [PATCH 6/7] ARM: EXYNOS4: Add save/restore for more ARM registers
In-Reply-To: <1308732405-16664-7-git-send-email-kgene.kim@samsung.com>
References: <1308732405-16664-1-git-send-email-kgene.kim@samsung.com>
	<1308732405-16664-7-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110622145452.GR23234@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 22, 2011 at 05:46:44PM +0900, Kukjin Kim wrote:
> From: Jaecheol Lee <jc.lee@samsung.com>
> 
> This patch adds save/restore for Power Control Register and
> Diagnostic Register.

NAK.  Please see my further suspend consolidation patches posted earlier.
I've also recently (last few days) moved these further forward and this
code no longer exists in this file (all it contains is the early
resume stuff.)

My guess is that these two registers are samsung specific, and so they
should be saved and restored by higher level code (eg, a syscore_ops
for exynos4 specific stuff.)
