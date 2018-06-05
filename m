From: kamill85@gmail.com (Kamil Leoniak)
Date: Tue, 5 Jun 2018 14:40:28 +0200
Subject: VMA/Paging apis broken on ARM/ARM64, possible work-arounds?
Message-ID: <CAOq87KqGmH92TOvxR1duCkiMqw+ZPH=NuBUAEhAztLxgRyW1TQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I have this problem with the kernel I'm working with. Normally PTEs
are made for every VM addr (ktext, modules and so on). On ARM/ARM64
certain VM addrs (in kernel) are allocated only with PMDs, they not
have a corresponding PTE cells.

This breaks a whole range of kernel APIs, for example "set_memory_rw".
It will work for any region that has a PTE, but if it's a direct PMD
mapping, it will fail.

Is there some simple work-around for that? Can I somehow remap a
specific VM address into a specific physical address? (to override the
"simple" PMD mapping).

Thank you!
