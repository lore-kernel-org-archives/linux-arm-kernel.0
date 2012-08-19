From: notasas@gmail.com (Grazvydas Ignotas)
Date: Mon, 20 Aug 2012 02:18:12 +0300
Subject: ARM hugetlb support?
Message-ID: <CANOLnOPLLQ=Cy5rvf5J7R96whrvLKO4HW9nVn4rQXqXCTVgCPA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

We are developing an application that's drawing various geometry on
1024x1024 framebuffer (lines, triangles, etc) and is running on
Cortex-A8 CPU. It seems this kind of application is suffering badly
from TLB misses, as A8 only has 32 entry TLB cache.

I've found that hugetlb support patches have been posted some months
ago [1]. I've been testing them with very good results [2]. Are there
still plans to further develop them and eventually merge them?


[1] http://marc.info/?l=linux-arm-kernel&m=132912620601308&w=2
[2] Cycle measurements of rendering full scene (using cycle counter in
A8), x1000 cycles:

       normal hugetlb improvement
scene1 28507  21351   34%
scene2 11710  10138   16%
scene3 17178  13631   26%
scene4 4372   3810    15%
scene5 3525   3255    8%

-- 
Gra?vydas
