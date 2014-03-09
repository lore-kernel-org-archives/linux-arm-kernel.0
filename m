From: broonie@kernel.org (Mark Brown)
Date: Sun, 9 Mar 2014 11:55:14 +0000
Subject: linux-next: build failure after merge of the arm-soc tree
Message-ID: <20140309115514.GY28112@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

After merging the arm-soc tree, today's linux-next build (20140309)
failed for arm64 defconfig like this:

/home/broonie/next/next/drivers/irqchip/irq-gic.c: In function 'gic_raise_softirq':
/home/broonie/next/next/drivers/irqchip/irq-gic.c:666:2: error: implicit declaration of function 'dmb' [-Werror=implicit-function-declaration]
  dmb(ishst);
  ^
/home/broonie/next/next/drivers/irqchip/irq-gic.c:666:6: error: 'ishst' undeclared (first use in this function)
  dmb(ishst);
      ^
/home/broonie/next/next/drivers/irqchip/irq-gic.c:666:6: note: each undeclared identifier is reported only once for each function it appears
in
cc1: some warnings being treated as errors
make[3]: *** [drivers/irqchip/irq-gic.o] Error 1

This is due to 8adbf57fc4294 (irqchip: gic: use dmb ishst instead of dsb
when raising a softirq) and has been going on for several builds now but
Stephen hasn't been including this build in his per-merge testing.  I've
abandoned arm64 testing since a simple revert causes problems for arm.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140309/ab01db95/attachment.sig>
