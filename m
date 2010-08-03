From: jamie@shareable.org (Jamie Lokier)
Date: Tue, 3 Aug 2010 20:42:32 +0100
Subject: [PATCH] ARM: Add SWP/SWPB emulation for ARMv7 processors (v6)
In-Reply-To: <AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
References: <20100719180136.20305.7333.stgit@e200687-lin>
	<20100719194940.GA14766@shutemov.name>
	<AANLkTik3CSSQLqajFimJxbq8TFBQ6iVx3RtdC9ObVj2-@mail.gmail.com>
Message-ID: <20100803194232.GK27827@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij wrote:
> 2010/7/19 Kirill A. Shutemov <kirill@shutemov.name>:
> 
> > Why do we need this? Why do not just fix broken programs?
> 
> People tend to use some third-party precompiled binaries, some of
> them compiled with a compiler using SWP.
> 
> A typical example is the CDC Java runtime, JRE.

Also people like to run the same binaries on different ARMs.
E.g. Debian, Ubuntu.

System pthread libraries can have multiple implementations, but
not every user of SWP or LDREX/STREX is in the pthread libraries.

-- Jamie
