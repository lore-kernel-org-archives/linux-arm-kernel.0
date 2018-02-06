From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 6 Feb 2018 22:17:13 +0000
Subject: [PATCH 0/9] Mitigations against spectre-v1 in the arm64 Linux
 kernel
In-Reply-To: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
References: <1517844864-15887-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180206221712.4sln72qnuqqko3yr@armageddon.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 05, 2018 at 03:34:15PM +0000, Will Deacon wrote:
> Hi all,
> 
> This series implements some mitigations against spectre-v1 for arm64. It
> broadly follows the work that has been done for x86, by implementing:
> 
>   * A back-end version of array_index_mask_nospec() to suppress any
>     compiler optimisations that could introduce unwanted speculative
>     paths
> 
>   * Masking of the syscall number to restrict speculation through the
>     syscall table
> 
>   * Masking of __user pointers prior to deference in uaccess routines
> 
> The latter introduces complications in access_ok and set_fs which are
> also handled in this series.

Queued for 4.16. Thanks.

-- 
Catalin
