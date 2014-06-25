From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 25 Jun 2014 15:43:54 +0200
Subject: [PATCH v8 4/9] sched: move no_new_privs into new atomic flags
In-Reply-To: <1403642893-23107-5-git-send-email-keescook@chromium.org>
References: <1403642893-23107-1-git-send-email-keescook@chromium.org>
 <1403642893-23107-5-git-send-email-keescook@chromium.org>
Message-ID: <20140625134354.GA7892@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/24, Kees Cook wrote:
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1307,8 +1307,7 @@ struct task_struct {
>  				 * execve */
>  	unsigned in_iowait:1;
>
> -	/* task may not gain privileges */
> -	unsigned no_new_privs:1;
> +	unsigned long atomic_flags; /* Flags needing atomic access. */
>
>  	/* Revert to default priority/policy when forking */
>  	unsigned sched_reset_on_fork:1;

Agreed, personally I like it more than seccomp->flags.

But probably it would be better to place the new member before/after
other bitfields to save the space?

Oleg.
