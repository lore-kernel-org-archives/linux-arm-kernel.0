From: pullip.cho@samsung.com (Cho KyongHo)
Date: Fri, 21 Dec 2012 09:56:57 +0900
Subject: [PATCH] ARM: dts: fix split memory bank for SSDK5440
In-Reply-To: <CAOesGMhVxidvs6Ywxzb=aK0GB0=bJMVfC7BWhXUQiPgeCpndbA@mail.gmail.com>
References: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
 <CAOesGMg03Yn=fDr1XqmbBUs=eZO0_8=iti1LUiJ6CX5n1Bm45g@mail.gmail.com>
 <1464138.NEt7mMkYJc@flatron> <20121220234146.GF14363@n2100.arm.linux.org.uk>
 <01f801cddf12$9f95c350$dec149f0$@samsung.com>
 <CAOesGMhVxidvs6Ywxzb=aK0GB0=bJMVfC7BWhXUQiPgeCpndbA@mail.gmail.com>
Message-ID: <000a01cddf16$13a027b0$3ae07710$%cho@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> From: Olof Johansson [mailto:olof at lixom.net]
> Sent: Friday, December 21, 2012 9:36 AM
> 
> On Thu, Dec 20, 2012 at 4:32 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> > Russell King - ARM Linux wrote:
> >>
> >
> > [...]
> >
> >> >
> >> > > What's the actual bug caused by this? The description is vague.
> >> >
> >> > The kernel panics early on NULL pointer dereference in memory
> >> > initialization.
> >>
> >
> > (Cc'ed KyongHo Cho)
> >
> > Yeah, correct. The size of memory bank should be under section size and
> > current section size is 256MiB on EXYNOS. So if we don't change the section
> > size, each memory bank should be under 256MiB. If not, as Tomasz said,
> > kernel panic happens in mem_init().
> 
> That's a bug somewhere, the device tree should describe the hardware,
> and not necessarily the massaged format that the kernel wants it in to
> not trigger a bug.
> 
> So I don't want to see this patch merged, I want to see a proper fix
> instead, please.
> 
> There are also already other exynos platforms and device trees with
> more than 256MB in the memory node. Changing all of them this way
> seems unreasonable.
> 
As Kukjin said earlier, the kernel panic may happen while gathering
memory statistics in mem_init()(arch/arm/mm/init.c). Russell King does not
agreed to modify mem_init() instead he told that a memory bank must not cross
section boundaries.
