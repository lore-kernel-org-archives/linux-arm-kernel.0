From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Tue, 25 Nov 2014 22:09:44 +0300
Subject: [PATCH v2] ARM: sa1100: improve irq handling
Message-ID: <1416942592-23059-1-git-send-email-dbaryshkov@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

This patch series makes sa1100 platform use MULTI_IRQ_HANDLER and irq
domains to handle interrupts on StrongARM platform. Also virtual irq
numbers are changed to start from 1 rather than 0. It doesn't change
the way how Linux programs the hardware, only software interfaces are
changed.

Changes since v1:
- Start IRQs from 1, freeing IRQ 0
- Merge identical functions in the last patch
- Other minor changes.
