From: tony@atomide.com (Tony Lindgren)
Date: Wed, 30 Mar 2016 14:15:07 -0700
Subject: [PATCH] ARM: dts: am43xx: fix edma memcpy channel allocation
In-Reply-To: <1457946110-4612-1-git-send-email-t-kristo@ti.com>
References: <1457946110-4612-1-git-send-email-t-kristo@ti.com>
Message-ID: <20160330211506.GD9329@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Tero Kristo <t-kristo@ti.com> [160314 02:02]:
> EDMA was allocating DMA channels 32 and 33 for memcpy usage, out of which
> channel 33 is actually used by DES crypto engine. This bad allocation of
> the channel causes a crash in the DES crypto engine, as the channel
> gets configured for memcpy usage instead of hardware <-> memory DMA.
> 
> Fixed by allocating DMA channels 58 and 59 for memcpy usage (I2C0 RX/TX),
> which are not used by anybody.

Thanks applying into omap-for-v4.6/fixes with Cc stable v4.4+.

Tony
