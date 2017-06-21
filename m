From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 21 Jun 2017 09:16:01 +0100
Subject: [PATCH v10 3/3] arm64/syscalls: Check address limit on user-mode
 return
In-Reply-To: <20170615011203.144108-3-thgarnie@google.com>
References: <20170615011203.144108-1-thgarnie@google.com>
 <20170615011203.144108-3-thgarnie@google.com>
Message-ID: <20170621081601.g6fsf6i3mxzar5sn@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 14, 2017 at 06:12:03PM -0700, Thomas Garnier wrote:
> Ensure the address limit is a user-mode segment before returning to
> user-mode. Otherwise a process can corrupt kernel-mode memory and
> elevate privileges [1].
> 
> The set_fs function sets the TIF_SETFS flag to force a slow path on
> return. In the slow path, the address limit is checked to be USER_DS if
> needed.
> 
> [1] https://bugs.chromium.org/p/project-zero/issues/detail?id=990
> 
> Signed-off-by: Thomas Garnier <thgarnie@google.com>
> ---
> v10 redesigns the change to use work flags on set_fs as recommended by
> Linus and agreed by others.
> 
> Based on next-20170609
> ---
>  arch/arm64/include/asm/thread_info.h | 4 +++-
>  arch/arm64/include/asm/uaccess.h     | 3 +++
>  arch/arm64/kernel/signal.c           | 5 +++++
>  3 files changed, 11 insertions(+), 1 deletion(-)

For arm64:

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
