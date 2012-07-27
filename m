From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 27 Jul 2012 09:59:21 +0200
Subject: Sharing resources between several drivers.
Message-ID: <CACKLOr2enmsVqQnJ8JZJJd3z3gGKDKwj74PnWKEk6SwSN=ZoJw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
we are trying to support pinctrl for i.MX21, i.MX1 and i.MX27.

In these chips, gpio and pinctrl use the same HW memory area
registers. This means that we have to request the same memory area
from two different drivers (gpio and pinctrl) but we don't know how to
do that.

A similar example available is mxs, but it only works with device
tree, so this problem is avoided.  However, some of these chips
(i.MX21, i.MX1...) don't support device tree yet, so we need to
provide backwards compatibility.

What is the right way to request the same memory region from two
different drivers? Moreover, how can we guarantee that there won't be
any conflicts when accessing these shared resources?

Regards.
-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
