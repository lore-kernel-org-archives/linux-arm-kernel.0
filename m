From: oleg@redhat.com (Oleg Nesterov)
Date: Fri, 11 Jul 2014 18:49:31 +0200
Subject: [PATCH v10 0/11] seccomp: add thread sync ability
In-Reply-To: <1405017631-27346-1-git-send-email-keescook@chromium.org>
References: <1405017631-27346-1-git-send-email-keescook@chromium.org>
Message-ID: <20140711164931.GA18473@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/10, Kees Cook wrote:
>
> This adds the ability for threads to request seccomp filter
> synchronization across their thread group (at filter attach time).
> For example, for Chrome to make sure graphic driver threads are fully
> confined after seccomp filters have been attached.
>
> To support this, locking on seccomp changes via thread-group-shared
> sighand lock is introduced, along with refactoring of no_new_privs. Races
> with thread creation are handled via delayed duplication of the seccomp
> task struct field and cred_guard_mutex.
>
> This includes a new syscall (instead of adding a new prctl option),
> as suggested by Andy Lutomirski and Michael Kerrisk.

I do not not see any problems in this version,

Reviewed-by: Oleg Nesterov <oleg@redhat.com>
