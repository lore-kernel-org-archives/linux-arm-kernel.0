From: jean.pihet@newoldbits.com (Jean Pihet)
Date: Tue, 17 Sep 2013 09:00:34 +0200
Subject: [PATCH 2/4] nohz_full: Kconfig: drop requrement on 64-bit
In-Reply-To: <1379370502-30376-3-git-send-email-khilman@linaro.org>
References: <1379370502-30376-1-git-send-email-khilman@linaro.org>
 <1379370502-30376-3-git-send-email-khilman@linaro.org>
Message-ID: <CAORVsuUrwH+4csjT_rpk2e7z7gje1ksrVdeTDYVAZ7bRZbd5UQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kevin,

FWIW typo in the title: 'requirement'.

Regards,
Jean

On Tue, Sep 17, 2013 at 12:28 AM, Kevin Hilman <khilman@linaro.org> wrote:
> Now that VIRT_CPU_ACCOUNTING_GEN no longer has a 64-bit requirement,
> it can be dropped here as well.
>
> Cc: Frederic Weisbecker <fweisbec@gmail.com>
> Signed-off-by: Kevin Hilman <khilman@linaro.org>
> ---
>  kernel/time/Kconfig | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
> index 2b62fe8..a54e3e9 100644
> --- a/kernel/time/Kconfig
> +++ b/kernel/time/Kconfig
> @@ -99,8 +99,6 @@ config NO_HZ_FULL
>         depends on SMP
>         # RCU_USER_QS dependency
>         depends on HAVE_CONTEXT_TRACKING
> -       # VIRT_CPU_ACCOUNTING_GEN dependency
> -       depends on 64BIT
>         select NO_HZ_COMMON
>         select RCU_USER_QS
>         select RCU_NOCB_CPU
> --
> 1.8.3
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
