From: dante.ferrari@gmail.com (=?ISO-8859-1?Q?Ferrari_Dante_L=E1szl=F3?=)
Date: Mon, 25 Nov 2013 12:38:38 +0100
Subject: MP11 port
Message-ID: <CAMou_+cJaQdfyxWnv0TrDdkHQ7cmJxCDb1yQFonqfFmUyx8QkA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear All,


Kernel fails at

'add_static_vm_early', so before than I posted before,

when I modify the structure

'realview_pb11mp_io_desc'  even the slightest bit. However to me it
seems that my new modified initial virtual mapping does not interlap
with each other.

I tried to modify the above structure in the hope so that the GIC
distrubutor and the CPU interface will match  my system's. But even
when I just modifiy the 'virtual' part  of an element of
realview_pb11mp_io_desc  to some random address in the vmalloc region,
to which the original does not map to (it maps 0xfb-0xfe If I remember
correctly) it fails at the very stage of add_static_vm_early.

Any hints?

Thanks
Dante
