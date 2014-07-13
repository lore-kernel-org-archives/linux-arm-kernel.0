From: jason@lakedaemon.net (Jason Cooper)
Date: Sun, 13 Jul 2014 18:48:31 -0400
Subject: [PATCH v2 02/15] ARM: pass IRQ domain to the core IRQ handler
In-Reply-To: <1404827141-30381-1-git-send-email-marc.zyngier@arm.com>
References: <1404827141-30381-1-git-send-email-marc.zyngier@arm.com>
Message-ID: <20140713224831.GJ13108@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Tue, Jul 08, 2014 at 02:45:40PM +0100, Marc Zyngier wrote:
> Calling irq_find_mapping from outside a irq_{enter,exit} section is
> unsafe and produces ugly messages if CONFIG_PROVE_RCU is enabled:
> If coming from the idle state, the rcu_read_lock call in irq_find_mapping
> will generate an an unpleasant warning.
> 
> A solution is to add a new handle_domain_irq entry point into
> the arm code that the interrupt controller code can call.
> This new function takes an irq_domain, and calls into irq_find_domain
> inside the irq_{enter,exit} block.
> 
> Interrupt controllers can then be updated to use the new mechanism.
> 
> Signed-off-by: Marc Zyngier <marc.zyngier@arm.com>
> ---
> Sending the right patch this time, with the missing includes that would
> otherwise break the build...
> 
>  arch/arm/include/asm/irq.h |  2 ++
>  arch/arm/kernel/irq.c      | 25 +++++++++++++++++++++----
>  2 files changed, 23 insertions(+), 4 deletions(-)

Please place in Russell's patch tracker,

Acked-by: Jason Cooper <jason@lakedaemon.net>

Once it lands in a release, we'll apply the rest.  Please send me a
gentle reminder ;-)

thx,

Jason.
