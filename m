From: schwidefsky@de.ibm.com (Martin Schwidefsky)
Date: Fri, 10 Jun 2016 12:51:58 +0200
Subject: [PATCH 11/14] s390/ptrace: run seccomp after ptrace
In-Reply-To: <1465506124-21866-12-git-send-email-keescook@chromium.org>
References: <1465506124-21866-1-git-send-email-keescook@chromium.org>
 <1465506124-21866-12-git-send-email-keescook@chromium.org>
Message-ID: <20160610125158.16dd5497@mschwide>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu,  9 Jun 2016 14:02:01 -0700
Kees Cook <keescook@chromium.org> wrote:

> Close the hole where ptrace can change a syscall out from under seccomp.
> 
> Signed-off-by: Kees Cook <keescook@chromium.org>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: linux-s390 at vger.kernel.org
> ---
>  arch/s390/kernel/ptrace.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)

If the change in semantics in regard to the audit of skipped system calls
is acceptable, the modified s390 arch code is ok.

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
