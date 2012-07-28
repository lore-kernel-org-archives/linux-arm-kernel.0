From: shawn.guo@linaro.org (Shawn Guo)
Date: Sat, 28 Jul 2012 21:41:16 +0800
Subject: [PATCH 2/2] ARM: dts: imx6q: Invert the GPIO controller order
In-Reply-To: <1343219864-3040-2-git-send-email-dirk.behme@de.bosch.com>
References: <1343219864-3040-1-git-send-email-dirk.behme@de.bosch.com>
 <1343219864-3040-2-git-send-email-dirk.behme@de.bosch.com>
Message-ID: <20120728134114.GH2128@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 25, 2012 at 02:37:44PM +0200, Dirk Behme wrote:
> From: Matthias Thomae <matthias.thomae@de.bosch.com>
> 
> The GPIO controllers in the device tree are registered dynamically
> via gpiochip_add and gpiochip_find_base in descending order (from
> ARCH_NR_GPIO to 0). This change reorders the controllers in the
> device tree (from gpio7 to gpio1) so that they finally appear in
> ascending order after registration.
> 
First of all, the device nodes in device tree are sorted in address
order, and should be independent with Linux implementation.

Secondly, I'm wondering why you care about the global gpio number,
as gpio and associated interrupt should be addressed by port + offset.

Regards,
Shawn
