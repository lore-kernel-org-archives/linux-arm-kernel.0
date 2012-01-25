From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Wed, 25 Jan 2012 21:29:49 +0300
Subject: [PATCH 04/21] ARM: omap2+: smartreflex: move smartreflex suspend
 to suspend_noirq
In-Reply-To: <1327504583-13408-5-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-5-git-send-email-j-pihet@ti.com>
Message-ID: <4F204A1D.4090005@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/25/2012 06:16 PM, Jean Pihet wrote:

> From: Colin Cross<ccross@android.com>

> Running without smartreflex for any significant time (on the order
> of seconds) is unsafe and can cause thermal runaway.  Move
> smartreflex suspend into suspend_noirq, so it happens as late as
> possible.  This prevents hangs that occur in a driver suspend
> handler from running without smartreflex enabled.  It will also
> reduce power used during suspend and resume, as the voltages will
> be lowered.

> May also indirectly fix imprecise external aborts seen during
> suspend, which could be caused by calls to sr_disable racing
> from calls to dvfs_scale and omap_sr_disable.

> Change-Id: Ia3c1e707bb1022ec102f506dc3ad48906e8890da

    This line has no place in the upstream commit. Please remove.

WBR, Sergei
