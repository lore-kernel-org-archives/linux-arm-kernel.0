From: ryan.harkin@linaro.org (Ryan Harkin)
Date: Mon, 3 Dec 2012 17:11:36 +0000
Subject: Use of CONFIG_ARM_GIC on aarch64
Message-ID: <CAD0U-hL-K+1PiBE87suWr6Vmg5Ad9=D2CLnuCFDNaoTh-1exbQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Catalin,

I have startied to host the Linaro aarch64 branch on the ARM Landing
Team's GIT repo.  This repo will start to be used for our Android
builds, etc, as we sort out the manifests and so on.

I thought I should make you aware that I've patched the use of
CONFIG_ARM_GIC [1] so that I can build 32- and 64-bit platforms from
the same tree.  I found that when I was building our existing vexpress
kernel, compilation failed for drivers/irqchip/gic.c.  Once fixed, it
failed to link due to drivers/irqchip/gic.c duplicating symbols that
are already in arch/arm/common/gic.c.

I realise that the irqchip will probably replace the
arch/arm/common/gic.c in the grand scheme of things, meaning no action
is needed on your behalf.  But I thought it might be worth telling you
that I'd hacked your driver in my tree.

Regards,
Ryan.

[1] http://git.linaro.org/gitweb?p=landing-teams/working/arm/kernel.git;a=commit;h=3da607b107ff9c3ed0c644a9f8bac1d980ee9c8f
