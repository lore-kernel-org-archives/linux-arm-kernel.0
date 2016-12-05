From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 5 Dec 2016 16:34:23 +0000
Subject: [PATCH 16/18] arm64: ptrace: handle ptrace_request differently
 for aarch32 and ilp32
In-Reply-To: <1477081997-4770-17-git-send-email-ynorov@caviumnetworks.com>
References: <1477081997-4770-1-git-send-email-ynorov@caviumnetworks.com>
 <1477081997-4770-17-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <20161205163422.GG14429@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 11:33:15PM +0300, Yury Norov wrote:
> New aarch32 ptrace syscall handler is introduced to avoid run-time
> detection of the task type.

What's wrong with the run-time detection? If it's just to avoid a
negligible overhead, I would rather keep the code simpler by avoiding
duplicating the generic compat_sys_ptrace().

-- 
Catalin
