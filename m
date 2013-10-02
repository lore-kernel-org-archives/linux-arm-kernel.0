From: liljegren.mats2@gmail.com (Mats Liljegren)
Date: Wed, 2 Oct 2013 15:01:50 +0200
Subject: Problems with IRQ affinity for timer64
Message-ID: <CA+xJJ185yai2P0a=5D6boyk2cArtfrHFov7XAQDQ1NqCh9p+Mg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

I'm doing a timer driver for timer64 found on a tci6638k2k board. The
idea is to use it as a generic interrupt source for testing purposes.

I want it to generate interrupts on a specific CPU that I decide. I
therefore try the following command:

echo 8 > /proc/irq/148/smp_affinity

But I get the following message:

-sh: echo: write error: Input/output error

This is timer18, which is supposed to be dedicated for CPU2 according
to the board documentation, but interrupts are taken on CPU0.

Looking at the specification for the driver itself, I cannot see
anything that the driver itself can do about this. I would expect that
the interrupt controller handles the affinity request.

I use the Arago version of Linux 3.8.4,
git://arago-project.org/git/projects/linux-keystone.git.

Board information: http://www.ti.com/product/tci6638k2k
Timer64 device data sheet: http://www.ti.com/lit/ug/sprugv5a/sprugv5a.pdf

What do I need to do to get this working?

Regards
Mats Liljegren
