From: broonie@kernel.org (Mark Brown)
Date: Tue, 11 Oct 2016 12:16:30 +0200
Subject: master build: 2 failures 4 warnings (v4.8-11811-g35ff96d)
In-Reply-To: <E1btqa6-0001tx-HV@optimist>
References: <E1btqa6-0001tx-HV@optimist>
Message-ID: <20161011101630.xtlcpw76nwjwcbzg@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 07:30:35AM +0100, Build bot for Mark Brown wrote:

Linus' tree is currently failing to build arm and arm64 allmodconfigs
with:

> 	arm64-allmodconfig
> ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

> 	arm-allmodconfig
> ERROR: "irq_set_parent" [drivers/mfd/tps65217.ko] undefined!

due to 6556bdacf646fc (mfd: tps65217: Add support for IRQs) since
irq_set_parent() isn't exported.  This has been present in -next
for getting on for a month, a patch was proposed adding the relevant
export but that isn't present in -next yet.

The function is being used in order to enable lazy IRQ disabling for
threaded interrupts:

	https://www.spinics.net/lists/arm-kernel/msg532864.html

What's the plan for getting this fixed in Linus' tree?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 455 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161011/37a83c95/attachment.sig>
