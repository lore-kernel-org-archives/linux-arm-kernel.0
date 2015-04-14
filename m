From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 15 Apr 2015 00:28:09 +0200
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <20150414150034.GF14546@e104818-lin.cambridge.arm.com>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <2069111.6po5Xr33Dn@wuerfel>
 <20150414150034.GF14546@e104818-lin.cambridge.arm.com>
Message-ID: <2947000.5TRODaJfhK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 14 April 2015 16:00:34 Catalin Marinas wrote:
> On Tue, Apr 14, 2015 at 04:07:36PM +0200, Arnd Bergmann wrote:
> > For completeness, there is yet another option, which would be to use the
> > exact system call table from arm64 and do all the emulation in user space
> > rather than the kernel. This would however be the least compatible with
> > existing source code, so you probably don't want to do that.
> 
> It would be great if this worked but I think we looked at it before and
> it seems nice until you hit the futex stuff and robust lists (I don't
> fully remember the details). Some of the structures (siginfo) would no
> longer be POSIX compliant and some of them aren't only accessed via libc
> to be able to create shadow copies.

Well, that may or may not be acceptable. Aarch64-ilp32 mode is a hack to
enable a very special class of applications, it's not like anyone would
want to run a full system for this and need POSIX compliance.

We could definitely be pragmatic and do whatever helps get the job
done. That said, it diverges further from what legacy 32-bit applications
expect to see, so this approach will likely make an application port harder,
not easier.

	Arnd
