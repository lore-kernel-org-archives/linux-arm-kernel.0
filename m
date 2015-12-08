From: balbi@ti.com (Felipe Balbi)
Date: Tue, 8 Dec 2015 12:03:55 -0600
Subject: [4.4-rc][PATCH v2] ARM: dts: am4372: fix clock source for arm twd
 and global timers
In-Reply-To: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
References: <1448898998-32749-1-git-send-email-grygorii.strashko@ti.com>
Message-ID: <87wpsolsvo.fsf@saruman.tx.rr.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Hi,

Grygorii Strashko <grygorii.strashko@ti.com> writes:
> ARM TWD and Global timer are clocked by PERIPHCLK which is MPU_CLK/2.
> But now they are clocked by dpll_mpu_m2_ck == MPU_CLK and, as result.
> Timekeeping core misbehaves. For example, execution of command
> "sleep 5" will take 10 sec instead of 5.
>
> Hence, fix it by adding mpu_periphclk ("fixed-factor-clock") and use
> it for clocking ARM TWD and Global timer (same way as on OMAP4).
>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Felipe Balbi <balbi@ti.com>
> Cc: Tero Kristo <t-kristo@ti.com>
> Fixes:commit 8cbd4c2f6a99 ("arm: boot: dts: am4372: add ARM timers and SCU nodes")
> Signed-off-by: Grygorii Strashko <grygorii.strashko@ti.com>

this seems to be the best fix for this problem, yeah.

Reviewed-by: Felipe Balbi <balbi@ti.com>

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 818 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20151208/b82a5540/attachment.sig>
