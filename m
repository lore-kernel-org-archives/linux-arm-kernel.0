From: siarhei.siamashka@nokia.com (Siarhei Siamashka)
Date: Thu, 29 Jul 2010 13:13:29 +0300
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <20100728060649.GB1656@ucw.cz>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
	<20100728060649.GB1656@ucw.cz>
Message-ID: <201007291313.29923.siarhei.siamashka@nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 28 July 2010 09:06:49 ext Pavel Machek wrote:
> On Mon 2010-07-19 22:02:12, Linus Walleij wrote:
> > 2010/7/19 Kirill A. Shutemov <kirill@shutemov.name>:
> > > Why do we need this? Why do not just fix broken programs?
> >
> > People tend to use some third-party precompiled binaries, some of
> > them compiled with a compiler using SWP.
>
> Why not just let the cpu emulate it? It surely will be faster...?

IMHO, being able to identify the usage of SWP instructions and fix bad
programs eventually (by spamming the said third-party programs bugtrackers) is
a good enough reason.

That's somewhat similar to userspace unaligned memory accesses handling,
except that the kernel being totally silent about them by default is not
helping much in practice.

-- 
Best regards,
Siarhei Siamashka
