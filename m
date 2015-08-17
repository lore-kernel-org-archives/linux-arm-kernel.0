From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 17 Aug 2015 17:40:03 +0100
Subject: [PATCH v4 2/5] irqchip, gicv3: Workaround for Cavium ThunderX
 erratum 23154
In-Reply-To: <1439576885-15621-3-git-send-email-rric@kernel.org>
References: <1439576885-15621-1-git-send-email-rric@kernel.org>
 <1439576885-15621-3-git-send-email-rric@kernel.org>
Message-ID: <20150817164003.GB2906@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Aug 14, 2015 at 08:28:02PM +0200, Robert Richter wrote:
> +struct static_key is_cavium_thunderx = STATIC_KEY_INIT_FALSE;

This could also be "static struct ...". BTW, the use of static_key
directly is deprecated, so just do:

static DEFINE_STATIC_KEY_FALSE(is_cavium_thunderx);

-- 
Catalin
