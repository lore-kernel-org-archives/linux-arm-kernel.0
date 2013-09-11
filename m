From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 11 Sep 2013 12:09:01 +0100
Subject: [PATCH 3/5] FS: Export poll_select_copy_remaining and rename
 poll_select_copy_remaining in compat.c so it does not pick the wrong copy.
In-Reply-To: <1378762380-13152-3-git-send-email-apinski@cavium.com>
References: <1378762380-13152-1-git-send-email-apinski@cavium.com>
 <1378762380-13152-3-git-send-email-apinski@cavium.com>
Message-ID: <20130911110901.GD26777@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 09, 2013 at 10:32:57PM +0100, Andrew Pinski wrote:
>   The ILP32 ABI in ARM64 uses a slightly different pselect from either
>   the compat or even the native LP64 ABI.  We would want to reuse some
>   of the code path that are used as the size of the timespec is the
>   same, so this patch exports poll_select_copy_remaining from
>   fs/select.c and renames the copy in fs/compat.c to make sure that it
>   is not being used.
> 
> Signed-off-by: Andrew Pinski <apinski@cavium.com>

I think this patch has to wait until we review the ILP32 ABI for arm64.
When I looked at this some time ago I thought we can just use the native
arm64 pselect6 and ppoll. Once we agree that's not possible we can push
this patch. On its own it doesn't have much value.

-- 
Catalin
