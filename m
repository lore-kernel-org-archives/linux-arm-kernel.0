From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 14 Apr 2015 16:00:34 +0100
Subject: [PATCH v4 00/24] ILP32 for ARM64
In-Reply-To: <2069111.6po5Xr33Dn@wuerfel>
References: <cover.1428953303.git.philipp.tomsich@theobroma-systems.com>
 <3234795.e0Uq9k2nUp@wuerfel>
 <76000FE9-46E5-4883-9E4F-C65444FD406C@theobroma-systems.com>
 <2069111.6po5Xr33Dn@wuerfel>
Message-ID: <20150414150034.GF14546@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 14, 2015 at 04:07:36PM +0200, Arnd Bergmann wrote:
> For completeness, there is yet another option, which would be to use the
> exact system call table from arm64 and do all the emulation in user space
> rather than the kernel. This would however be the least compatible with
> existing source code, so you probably don't want to do that.

It would be great if this worked but I think we looked at it before and
it seems nice until you hit the futex stuff and robust lists (I don't
fully remember the details). Some of the structures (siginfo) would no
longer be POSIX compliant and some of them aren't only accessed via libc
to be able to create shadow copies.

-- 
Catalin
