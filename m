From: nm@ti.com (Menon, Nishanth)
Date: Mon, 30 May 2011 09:11:54 -0500
Subject: [PATCH] OMAP2/4: PM: Boot message is not an error/info, and not
	helpful, remove it
In-Reply-To: <4DE39F2B.3040506@ti.com>
References: <1306751527-15929-1-git-send-email-santosh.shilimkar@ti.com>
	<4DE39D40.2060500@ru.mvista.com> <4DE39F2B.3040506@ti.com>
Message-ID: <BANLkTi=eZBj1BsRZ92zbo-8pUfrGwba-5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 30, 2011 at 08:44, Santosh Shilimkar
<santosh.shilimkar@ti.com> wrote:
> On 5/30/2011 7:06 PM, Sergei Shtylyov wrote:
>>
>> Hello.
>>
>> Santosh Shilimkar wrote:
>>
>>> The commit '99aa18278e' removed the boot messege for OMAP3. Do the same
>>
>> Please specify that commit's summary in parens -- for the human readers.
>> Oh, and you don't need quotes around commit ID too.
>>
> Yes I missed that. Updated patch below.
>
> Regards
> Santosh
>
> From 53e986a2a43dc204146af99c2d7a906dba781ea0 Mon Sep 17 00:00:00 2001
> From: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Date: Mon, 30 May 2011 15:52:01 +0530
> Subject: [PATCH] OMAP2/4: PM: Boot message is not an error/info, and not
> helpful, remove it
>
> The commit 99aa18278e (OMAP3: PM: Boot message is not an error,
> and not helpful, remove it), removed the boot message for OMAP3.
> Do the same for OMAP2 and OMAP4 since it's really just noise in the
> boot log and PM init is always called.
>
> Signed-off-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
> Cc: Kevin Hilman <khilman@ti.com>

Acked-by: Nishanth Menon <nm@ti.com>
Regards,
Nishanth Menon


> ---
> ?arch/arm/mach-omap2/pm24xx.c | ? ?1 -
> ?arch/arm/mach-omap2/pm44xx.c | ? ?2 --
> ?2 files changed, 0 insertions(+), 3 deletions(-)
>
> diff --git a/arch/arm/mach-omap2/pm24xx.c b/arch/arm/mach-omap2/pm24xx.c
> index df3ded6..5970759 100644
> --- a/arch/arm/mach-omap2/pm24xx.c
> +++ b/arch/arm/mach-omap2/pm24xx.c
> @@ -442,7 +442,6 @@ static int __init omap2_pm_init(void)
> ? ? ? ?if (!cpu_is_omap24xx())
> ? ? ? ? ? ? ? ?return -ENODEV;
>
> - ? ? ? printk(KERN_INFO "Power Management for OMAP2 initializing\n");
> ? ? ? ?l = omap2_prm_read_mod_reg(OCP_MOD, OMAP2_PRCM_REVISION_OFFSET);
> ? ? ? ?printk(KERN_INFO "PRCM revision %d.%d\n", (l >> 4) & 0x0f, l & 0x0f);
>
> diff --git a/arch/arm/mach-omap2/pm44xx.c b/arch/arm/mach-omap2/pm44xx.c
> index 59a870b..a6259d6 100644
> --- a/arch/arm/mach-omap2/pm44xx.c
> +++ b/arch/arm/mach-omap2/pm44xx.c
> @@ -103,8 +103,6 @@ static int __init omap4_pm_init(void)
> ? ? ? ?if (!cpu_is_omap44xx())
> ? ? ? ? ? ? ? ?return -ENODEV;
>
> - ? ? ? pr_err("Power Management for TI OMAP4.\n");
> -
> ? ? ? ?ret = pwrdm_for_each(pwrdms_setup, NULL);
> ? ? ? ?if (ret) {
> ? ? ? ? ? ? ? ?pr_err("Failed to setup powerdomains\n");
> --
> 1.6.0.4
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at ?http://vger.kernel.org/majordomo-info.html
>
