From: magnus.damm@gmail.com (Magnus Damm)
Date: Sat, 14 Feb 2015 09:58:42 +0000
Subject: [PATCH] ARM: shmobile: Remove redundant cpu_disable implementation
In-Reply-To: <1423874461-2405-1-git-send-email-sboyd@codeaurora.org>
References: <1423874461-2405-1-git-send-email-sboyd@codeaurora.org>
Message-ID: <CANqRtoRBpf6gmqUb1avYFWV0sJ5Oo_ZcymRZoDKtm7sgS-zBhA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stephen,

On Sat, Feb 14, 2015 at 12:41 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> By default only the non-boot CPUs can be hotplugged if the
> smp_operations structure doesn't have the cpu_disable function
> pointer set. r8a7779_cpu_disable() implements the same logic,
> only non-boot CPUs can be hotplugged, so it's redundant to
> override the default behavior.
>
> Signed-off-by: Stephen Boyd <sboyd@codeaurora.org>
> ---
>  arch/arm/mach-shmobile/smp-r8a7779.c | 7 -------
>  1 file changed, 7 deletions(-)

Thanks for breaking out this change. It looks good to me!

Acked-by: Magnus Damm <damm+renesas@opensource.se>

Cheers,

/ magnus
