From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 5 Jun 2018 16:58:03 +0100
Subject: VMA/Paging apis broken on ARM/ARM64, possible work-arounds?
In-Reply-To: <CAOq87KqGmH92TOvxR1duCkiMqw+ZPH=NuBUAEhAztLxgRyW1TQ@mail.gmail.com>
References: <CAOq87KqGmH92TOvxR1duCkiMqw+ZPH=NuBUAEhAztLxgRyW1TQ@mail.gmail.com>
Message-ID: <20180605155803.k3ei6rdcreuzemkb@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 02:40:28PM +0200, Kamil Leoniak wrote:
> Hi,

Hi,

> I have this problem with the kernel I'm working with. Normally PTEs
> are made for every VM addr (ktext, modules and so on). On ARM/ARM64
> certain VM addrs (in kernel) are allocated only with PMDs, they not
> have a corresponding PTE cells.
> 
> This breaks a whole range of kernel APIs, for example "set_memory_rw".
> It will work for any region that has a PTE, but if it's a direct PMD
> mapping, it will fail.

As Russell said, for various reasons, APIs which change the attributes
or permissions of pages aren't supported on arbitrary mappings.

> Is there some simple work-around for that? Can I somehow remap a
> specific VM address into a specific physical address? (to override the
> "simple" PMD mapping).

Could you please explain your use-case?

Why are you trying to remap a range that already has a mapping?

Thanks,
Mark.
