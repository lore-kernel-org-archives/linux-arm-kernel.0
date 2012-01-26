From: sshtylyov@ru.mvista.com (Sergei Shtylyov)
Date: Thu, 26 Jan 2012 15:29:21 +0400
Subject: [PATCH 10/21] OMAP3+: Smartreflex: clear ERRCONFIG_VPBOUNDINTST
 only on a need
In-Reply-To: <1327504583-13408-11-git-send-email-j-pihet@ti.com>
References: <1327504583-13408-1-git-send-email-j-pihet@ti.com>
 <1327504583-13408-11-git-send-email-j-pihet@ti.com>
Message-ID: <4F213911.1080806@ru.mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 25-01-2012 19:16, Jean Pihet wrote:

> From: Nishanth Menon<nm@ti.com>

> ERRCONFIG register's VPBOUNDINTST has an additional functional meaning
> It force clears Sr_interruptz internal signal. This can result in
> scenarios where VP->  SR protocol is violated where voltage processor's
> As interruptz is already high, VP will never clear the signal vpirqclr.
> Therefore during the next force update to reset to nominal voltage,
> VP can?t pulsed vpirqclr =>  PRCM HW can?t generate the tranxdone IRQ
> and the situation is not recoverable untill a cold reset is invoked.

> To prevent this situation, check if status is set before clearing the
> status as this needs to be done only on a need basis.

> Change-Id: Ic8065d7d79df143bf46877c50f5b6b19ed105a70

    Please remove this line.

> Reported-by: Vincent Bour<v-bour@ti.com>
> Signed-off-by: Nishanth Menon<nm@ti.com>
> Signed-off-by: Jean Pihet<j-pihet@ti.com>

WBR, Sergei
