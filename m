From: dbaryshkov@gmail.com (Dmitry Eremin-Solenikov)
Date: Wed, 15 Jun 2011 11:57:58 +0000 (UTC)
Subject: GPIO vs. other drivers order
Message-ID: <ita6o6$od6$1@dough.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello, colleagues,

I'm currently looking at cleaning up LoCoMo and Scoop2 drivers (custom
Sharp ASICs used by Sharp Zaurus PDAs). One of the problems I'm stuck at
is about GPIO parts of that chips: there are plenty of other devices
depending on GPIO pins working correctly (ranging from board code
itself up to several other sub-drivers).

What would be the better approach: to create a basic-mmio-gpio node (and
hope for the order of initialization to be correct) or embed bgpio into
main driver and call all necessary hooks directly from it?

-- 
With best wishes
Dmitry
