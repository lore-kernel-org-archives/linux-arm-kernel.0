From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 23 Jun 2014 12:13:43 +0100
Subject: [PATCH] ARM64: implement TASK_SIZE_OF
In-Reply-To: <1403122209-26352-1-git-send-email-ccross@android.com>
References: <1403122209-26352-1-git-send-email-ccross@android.com>
Message-ID: <20140623111343.GC15907@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 18, 2014 at 09:10:09PM +0100, Colin Cross wrote:
> include/linux/sched.h implements TASK_SIZE_OF as TASK_SIZE if it
> is not set by the architecture headers.  TASK_SIZE uses the
> current task to determine the size of the virtual address space.
> On a 64-bit kernel this will cause reading /proc/pid/pagemap of a
> 64-bit process from a 32-bit process to return EOF when it reads
> past 0xffffffff.
> 
> Implement TASK_SIZE_OF exactly the same as TASK_SIZE with
> test_tsk_thread_flag instead of test_thread_flag.
> 
> Cc: stable at vger.kernel.org
> Signed-off-by: Colin Cross <ccross@android.com>

Thanks. Applied.

-- 
Catalin
