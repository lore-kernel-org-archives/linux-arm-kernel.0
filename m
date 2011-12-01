From: will.deacon@arm.com (Will Deacon)
Date: Thu, 1 Dec 2011 14:37:31 +0000
Subject: [V2 2/3] ARM: add TRACEHOOK support
In-Reply-To: <1322664382-21793-3-git-send-email-stevenrwalter@gmail.com>
References: <1322664382-21793-1-git-send-email-stevenrwalter@gmail.com>
 <1322664382-21793-3-git-send-email-stevenrwalter@gmail.com>
Message-ID: <20111201143731.GE27656@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Minor nit (pedantry):

On Wed, Nov 30, 2011 at 02:46:21PM +0000, Steven Walter wrote:
> +        if (why) {
> +                tracehook_report_syscall_exit(regs, 0);
> +        } else {
> +                if (tracehook_report_syscall_entry(regs))
> +                        current_thread_info()->syscall = -1;
> +        }

You could bang the second if next to the else and lose the braces.

Will
