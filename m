From: R00091@freescale.com (Nguyen Dinh-R00091)
Date: Tue, 30 Nov 2010 09:33:54 -0700
Subject: [PATCH] ARM: imx: Add mx53 changes to crm_regs
In-Reply-To: <AANLkTikbroTO6A=1_nBrO=y-O-MiGgtZAN5tg32+4-c=@mail.gmail.com>
References: <1291071265-4238-1-git-send-email-Dinh.Nguyen@freescale.com>
	<AANLkTikbroTO6A=1_nBrO=y-O-MiGgtZAN5tg32+4-c=@mail.gmail.com>
Message-ID: <56132A77AB93C141BF06E6B96CA6CFEA027763@039-SN1MPN1-004.039d.mgd.msft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

 

From: Fabio Estevam [mailto:festevam at gmail.com] 
Sent: Monday, November 29, 2010 6:11 PM
To: Nguyen Dinh-R00091
Cc: linux-kernel at vger.kernel.org; amit.kucheria at canonical.com; linux at arm.linux.org.uk; s.hauer at pengutronix.de; eric at eukrea.com; u.kleine-koenig at pengutronix.de; linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH] ARM: imx: Add mx53 changes to crm_regs

 

Hi Dinh,

On Mon, Nov 29, 2010 at 8:54 PM,  <Dinh.Nguyen@freescale.com> wrote:
...
>
>  /* eSDHC */
> -CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC1)
> -CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC1)
> -CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC1)
> +CLK_GET_RATE(esdhc1, 1, ESDHC1_MSHC2)
> +CLK_SET_PARENT(esdhc1, 1, ESDHC1_MSHC2)
> +CLK_SET_RATE(esdhc1, 1, ESDHC1_MSHC2)
>
> -CLK_GET_RATE(esdhc2, 1, ESDHC2_MSHC2)
> -CLK_SET_PARENT(esdhc2, 1, ESDHC2_MSHC2)
> -CLK_SET_RATE(esdhc2, 1, ESDHC2_MSHC2)
> +CLK_GET_RATE(esdhc2, 1, ESDHC2_3_MSHC2)
> +CLK_SET_PARENT(esdhc2, 1, ESDHC2_3_MSHC2)
> +CLK_SET_RATE(esdhc2, 1, ESDHC2_3_MSHC2)

Shouldn?t this be part of another patch?

I needed these changes because the patch would break the build if these changes are made? Are you referring to the change from ESDHC1_MSHC1 -> ESDHC1_MSHC2, or ESDHC2_MSHC2 -> ESDCH2_3_MSHC2? 

For the case of ESDHC1_MSHC1 -> ESDHC1_MSHC2, it just a matter of semantics fix(there is no MSHC1 in MX51 or MX53). But for the ESDHC2_MSHC2 -> ESDCH2_3_MSHC2 change, its because for MX53, ESDHC2(which was getting the clocks from the PLLs and feeding them to ESDHC3) is now reversed(ESDHC3 is getting clocks from the PLL and feeding it to ESDHC2). 

Dinh



Regards,

Fabio Estevam

-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20101130/f670941f/attachment-0001.html>
