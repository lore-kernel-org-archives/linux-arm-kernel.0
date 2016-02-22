From: broonie@kernel.org (Mark Brown)
Date: Mon, 22 Feb 2016 19:25:42 +0900
Subject: next-20160222 build: 5 failures 9 warnings (next-20160222)
In-Reply-To: <E1aXlz4-000486-Pb@optimist>
References: <E1aXlz4-000486-Pb@optimist>
Message-ID: <20160222102542.GZ18327@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 22, 2016 at 08:36:46AM +0000, Build bot for Mark Brown wrote:

For the past few days -next has been failing to build an arm
allmodconfig due to:

> 	arm-allmodconfig
> ../arch/arm/kernel/hyp-stub.S:168: Error: selected processor does not support ARM mode `ubfx r7,r7,#28,#4'
> ../arch/arm/kernel/hyp-stub.S:176: Error: selected processor does not support ARM mode `isb'

caused by e59941b9b3817c (ARM: 8527/1: virt: enable GICv3 system
registers) in the ARM tree.  My hot take is that it looks like
CONFIG_ARM_GIC_V3 needs tighter dependencies so it can't get enabled for
a v6 system but I could be wrong.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160222/9736c9c3/attachment.sig>
