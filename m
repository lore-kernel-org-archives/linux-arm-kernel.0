From: marc.zyngier@arm.com (Marc Zyngier)
Date: Thu, 1 Feb 2018 17:23:46 +0000
Subject: [PATCH v2] irqchip/gic-v3: Ignore disabled ITS nodes
In-Reply-To: <20180201170329.26916-1-sboyd@codeaurora.org>
References: <20180201170329.26916-1-sboyd@codeaurora.org>
Message-ID: <38dd5843-9290-28b2-8acb-aabb81acf00d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/02/18 17:03, Stephen Boyd wrote:
> On some platforms there's an ITS available but it's not enabled
> because reading or writing the registers is denied by the
> firmware. In fact, reading or writing them will cause the system
> to reset. We could remove the node from DT in such a case, but
> it's better to skip nodes that are marked as "disabled" in DT so
> that we can describe the hardware that exists and use the status
> property to indicate how the firmware has configured things.
> 
> Cc: Stuart Yoder <stuyoder@gmail.com>
> Cc: Laurentiu Tudor <laurentiu.tudor@nxp.com>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Rajendra Nayak <rnayak@codeaurora.org>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>

Queued, thanks Stephen.

	M.
-- 
Jazz is not dead. It just smells funny...
