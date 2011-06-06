From: santosh.shilimkar@ti.com (Santosh Shilimkar)
Date: Mon, 06 Jun 2011 12:32:05 +0530
Subject: [PATCH] ARM: omap4: gpio: fix setting IRQWAKEN bits
In-Reply-To: <1307214239-16316-1-git-send-email-ccross@android.com>
References: <1307214239-16316-1-git-send-email-ccross@android.com>
Message-ID: <4DEC7B6D.6060901@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 6/5/2011 12:33 AM, Colin Cross wrote:
> Setting the IRQWAKEN bit was overwriting previous IRQWAKEN bits,
> causing only the last bit set to take effect, resulting in lost
> wakeups when the GPIO controller is in idle.
>
> Replace direct writes to IRQWAKEN with writes to SETWKUENA and
> CLEARWKUEN.
>
> Signed-off-by: Colin Cross<ccross@android.com>

Looks good. This needs to be fixed on top of the clean-up
branch where GPIO movemnt to driver/gpio/* happening.

For this change,
Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>	
