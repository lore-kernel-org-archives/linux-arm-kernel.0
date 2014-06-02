From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 02 Jun 2014 13:45:39 +0200
Subject: [PATCH] arm64: uid16: fix __kernel_old_{gid,uid}_t definitions
In-Reply-To: <1401706049-1787-1-git-send-email-will.deacon@arm.com>
References: <1401706049-1787-1-git-send-email-will.deacon@arm.com>
Message-ID: <24318565.Hg3EHrYVE1@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 02 June 2014 11:47:29 Will Deacon wrote:
> Whilst native arm64 applications don't have the 16-bit UID/GID syscalls
> wired up, compat tasks can still access them. The 16-bit wrappers for
> these syscalls use __kernel_old_uid_t and __kernel_old_gid_t, which must
> be 16-bit data types to maintain compatibility with the 16-bit UIDs used
> by compat applications.
> 
> This patch defines 16-bit __kernel_old_{gid,uid}_t types for arm64
> instead of using the 32-bit types provided by asm-generic.
> 
> Signed-off-by: Will Deacon <will.deacon@arm.com>

Acked-by: Arnd Bergmann <arnd@arndb.de>

Is this a theoretical problem, or did you actually encounter binaries
with old uid syscalls?

	Arnd
