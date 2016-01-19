From: tony@atomide.com (Tony Lindgren)
Date: Tue, 19 Jan 2016 13:57:45 -0800
Subject: [PATCH 3/5] ARM: OMAP2+: Fix save_secure_ram_context for rodata
In-Reply-To: <569E845F.7080001@cogentembedded.com>
References: <1453225734-16993-1-git-send-email-tony@atomide.com>
 <1453225734-16993-4-git-send-email-tony@atomide.com>
 <569E845F.7080001@cogentembedded.com>
Message-ID: <20160119215745.GF19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> [160119 10:46]:
> >--- a/arch/arm/mach-omap2/sleep34xx.S
> >+++ b/arch/arm/mach-omap2/sleep34xx.S
> >@@ -93,8 +93,12 @@ ENTRY(enable_omap3630_toggle_l2_on_restore)
> >  	ldmfd	sp!, {pc}	@ restore regs and return
> >  ENDPROC(enable_omap3630_toggle_l2_on_restore)
> >
> >-	.text
> >-/* Function to call rom code to save secure ram context */
> >+/*
> >+ * Function to call rom code to save secure ram context, This gets
> 
>    s/,/./?

Will fix thanks.

Tony
