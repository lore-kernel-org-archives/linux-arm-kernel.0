From: jmorris@namei.org (James Morris)
Date: Thu, 12 May 2011 21:33:27 +1000 (EST)
Subject: [PATCH 3/5] v2 seccomp_filters: Enable ftrace-based system call
	filtering
In-Reply-To: <1305169376-2363-1-git-send-email-wad@chromium.org>
References: <1304017638.18763.205.camel@gandalf.stny.rr.com>
	<1305169376-2363-1-git-send-email-wad@chromium.org>
Message-ID: <alpine.LRH.2.00.1105122131530.31507@tundra.namei.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 11 May 2011, Will Drewry wrote:

> +void seccomp_filter_log_failure(int syscall)
> +{
> +	printk(KERN_INFO
> +		"%s[%d]: system call %d (%s) blocked at ip:%lx\n",
> +		current->comm, task_pid_nr(current), syscall,
> +		syscall_nr_to_name(syscall), KSTK_EIP(current));
> +}

I think it'd be a good idea to utilize the audit facility here.


- James
-- 
James Morris
<jmorris@namei.org>
