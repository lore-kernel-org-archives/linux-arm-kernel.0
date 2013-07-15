From: gorcunov@gmail.com (Cyrill Gorcunov)
Date: Mon, 15 Jul 2013 21:32:38 +0400
Subject: [PATCH] arm: align shared memory unconditionally to the SHMLBA
 boundary
In-Reply-To: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
References: <1361254269-3444-1-git-send-email-alekskartashov@parallels.com>
Message-ID: <20130715173238.GJ1730@moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 19, 2013 at 10:11:09AM +0400, Alexander Kartashov wrote:
> Currently IPC SHM works in a strange way on ARM:
> the syscall sys_shmat() requires the argument shmaddr
> be SHMLBA-aligned (ARM has the macro __ARCH_FORCE_SHMLBA
> unconditionally defined) but allocates memory that
> isn't SHMLBA-aligned because the value of memory alignment
> depends on presense of certain cache aliases.

Hi guys, is there some conclusion on this patch? It has been sent
almost 5 months back ;)
