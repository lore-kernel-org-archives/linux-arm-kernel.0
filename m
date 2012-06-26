From: alexander.shishkin@linux.intel.com (Alexander Shishkin)
Date: Tue, 26 Jun 2012 12:15:23 +0300
Subject: [PATCH v6 13/14] usb: otg: add basic mxs phy driver support
In-Reply-To: <1340260875-21934-14-git-send-email-richard.zhao@freescale.com>
References: <1340260875-21934-1-git-send-email-richard.zhao@freescale.com>
 <1340260875-21934-14-git-send-email-richard.zhao@freescale.com>
Message-ID: <87fw9iv3h0.fsf@ashishki-desk.ger.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Zhao <richard.zhao@freescale.com> writes:

> +config USB_MXS_PHY
> +	tristate "Freescale MXS USB PHY support"
> +	select STMP_DEVICE
> +	select USB_OTG_UTILS

There should also be a dependency on ARM (or maybe even ARCH_MXS),
because you're using writel_relaxed() here, which only exists on arm and
sh4 and enabling it on other architectures breaks compilation.

Regards,
--
Alex
