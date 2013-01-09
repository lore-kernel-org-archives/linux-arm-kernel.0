From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 9 Jan 2013 21:15:20 +0000
Subject: [PATCH] ARM: nommu: re-enable use of vexpress without
 ARCH_MULTIPLATFORM
In-Reply-To: <alpine.LFD.2.02.1301091554250.6300@xanadu.home>
References: <1357755328-17075-1-git-send-email-jonathan.austin@arm.com>
 <201301092022.49130.arnd@arndb.de>
 <alpine.LFD.2.02.1301091554250.6300@xanadu.home>
Message-ID: <201301092115.20327.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 09 January 2013, Nicolas Pitre wrote:
> > If we decide that building an allnoconfig without any platform
> > is actually ok, we could just as well rip out that error statement.
> 
> Is it expected for allnoconfig kernels to still boot on other 
> architectures? If so I think we should try to still provide a valid 
> config even in the allnoconfig case.

The practical use of a kernel without any device drivers or file
systems is pretty low, I would not expect such a kernel to be
any useful. Having a regular configuration where you just disable
the platform support is a little different. This could happen
when the platform you are building for depends on a specific
feature to be enabled or disabled and that option is accidentally
changed. E.g. when you turn off MMU support on a platform that
depends on having that, we fall back to the default platform
(versatile?). The same may happen when you build for a single
board and one of it's dependencies goes away.

	Arnd
