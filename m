From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Fri, 7 Apr 2017 10:31:21 +0200
Subject: [PATCH v9 03/12] ARM: EXYNOS: remove secondary startup
 initialization from smp_prepare_cpus
In-Reply-To: <1490879826-16754-4-git-send-email-pankaj.dubey@samsung.com>
References: <CGME20170330131424epcas5p4fccfab06e5d77d70d09c3835c3332ee5@epcas5p4.samsung.com>
 <1490879826-16754-1-git-send-email-pankaj.dubey@samsung.com>
 <1490879826-16754-4-git-send-email-pankaj.dubey@samsung.com>
Message-ID: <CAJKOXPcyvVmsAvBUhqxV=WuFKjqKCqcidTFQ5mTtUFDAfmpcrg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 30, 2017 at 3:16 PM, Pankaj Dubey <pankaj.dubey@samsung.com> wrote:
> We are taking care of setting secondary cpu boot address in
> exynos_boot_secondary just before sending ipi to secondary CPUs,
> so we can safely remove this setting from smp_prepare_cpus.
>
> Signed-off-by: Pankaj Dubey <pankaj.dubey@samsung.com>
> ---
>  arch/arm/mach-exynos/platsmp.c | 26 --------------------------
>  1 file changed, 26 deletions(-)
>

I also wondered why we need this twice... Testing on different
platforms would be nice to be sure that we did not miss anything but
it looks correct for me. For my reference:
Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof
