From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 16 Dec 2015 17:08:35 +0100
Subject: [PATCH v6 15/20] arm64: signal: move ilp32 and lp64 common code
 to separated file
In-Reply-To: <1450215766-14765-16-git-send-email-ynorov@caviumnetworks.com>
References: <1450215766-14765-1-git-send-email-ynorov@caviumnetworks.com>
 <1450215766-14765-16-git-send-email-ynorov@caviumnetworks.com>
Message-ID: <6089723.moZBJ98Dq4@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 16 December 2015 00:42:41 Yury Norov wrote:
> +               sigtramp = ka->sa.sa_restorer;
> +#ifdef CONFIG_ARM64_ILP32
> +       else if (is_ilp32_compat_task())
> +               sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp_ilp32);
> +#endif
> +       else
> +               sigtramp = VDSO_SYMBOL(current->mm->context.vdso, sigtramp);
> 

This is another case where I think it's more readable to remove the #ifdef,
with no change in behavior.

	Arnd
