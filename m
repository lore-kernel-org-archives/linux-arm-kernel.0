From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Tue, 5 Jun 2018 14:06:38 +0100
Subject: VMA/Paging apis broken on ARM/ARM64, possible work-arounds?
In-Reply-To: <CAOq87KqGmH92TOvxR1duCkiMqw+ZPH=NuBUAEhAztLxgRyW1TQ@mail.gmail.com>
References: <CAOq87KqGmH92TOvxR1duCkiMqw+ZPH=NuBUAEhAztLxgRyW1TQ@mail.gmail.com>
Message-ID: <20180605130638.GV17671@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 05, 2018 at 02:40:28PM +0200, Kamil Leoniak wrote:
> I have this problem with the kernel I'm working with. Normally PTEs
> are made for every VM addr (ktext, modules and so on). On ARM/ARM64
> certain VM addrs (in kernel) are allocated only with PMDs, they not
> have a corresponding PTE cells.
> 
> This breaks a whole range of kernel APIs, for example "set_memory_rw".

These return -EINVAL if you try to use them on a region that isn't
supported by the implementation.  Their use on the kernel is not
supported, sorry.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line in suburbia: sync at 8.8Mbps down 630kbps up
According to speedtest.net: 8.21Mbps down 510kbps up
