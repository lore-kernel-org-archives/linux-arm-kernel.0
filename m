From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 20 Dec 2012 16:32:11 -0800
Subject: [PATCH] ARM: dts: fix split memory bank for SSDK5440
In-Reply-To: <20121220234146.GF14363@n2100.arm.linux.org.uk>
References: <1356030217-5472-1-git-send-email-kgene.kim@samsung.com>
 <CAOesGMg03Yn=fDr1XqmbBUs=eZO0_8=iti1LUiJ6CX5n1Bm45g@mail.gmail.com>
 <1464138.NEt7mMkYJc@flatron> <20121220234146.GF14363@n2100.arm.linux.org.uk>
Message-ID: <01f801cddf12$9f95c350$dec149f0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux wrote:
> 

[...]

> >
> > > What's the actual bug caused by this? The description is vague.
> >
> > The kernel panics early on NULL pointer dereference in memory
> > initialization.
> 

(Cc'ed KyongHo Cho)

Yeah, correct. The size of memory bank should be under section size and
current section size is 256MiB on EXYNOS. So if we don't change the section
size, each memory bank should be under 256MiB. If not, as Tomasz said,
kernel panic happens in mem_init().

> And of course the debugging information is included in the commit log so
> that others can see what problem you're experiencing and make a decision
> whether the proposed solution is the right one...

Yeah, why not, I will add it in next version.

Thanks.

- Kukjin
