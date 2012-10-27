From: rtivy@ti.com (Tivy, Robert)
Date: Sat, 27 Oct 2012 00:59:06 +0000
Subject: [PATCH v2 1/6] ARM: davinci: Changed pr_warning() to pr_warn()
In-Reply-To: <508A5BF3.2060803@mvista.com>
References: <1351197357-23528-1-git-send-email-rtivy@ti.com>
 <508A5BF3.2060803@mvista.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311F0E03@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Thanks for your comments, Sergei.  Please see below...

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: Friday, October 26, 2012 2:46 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark; Nori, Sekhar
> Subject: Re: [PATCH v2 1/6] ARM: davinci: Changed pr_warning() to
> pr_warn()
> 
> Hello.
> 
>     It's not a good idea to send multiple patches with the same
> subject.
> Actually, in this case it's worth merging all 4 patches into one.

My first patch submission had them all as one patch, but Sekhar asked that they be split into 4 separate patches to make the merge easier.

I can make each one have a different subject, though.

> 
> On 26-10-2012 0:35, Robert Tivy wrote:
> 
> > Also, while modifying those pr_warning() calls I changed hardcoded
> > function names to use '"%s:", __func__' instead
> 
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
> > ---
> > Clean up files that will be otherwise modified in subsequent patch.
> 
> > Applies to v3.5 tag (commit 28a33cbc24e4256c143dce96c7d93bf423229f92)
> of
> > Linus' mainline kernel at git.kernel.org.
> 
>     3.5 is too old. Why not to 3.6 or even 3.7-rc2?

I will attempt to recreate this patch series on 3.7-rc2, although I will need to change it to use the newer "rproc" APIs and data structures.

> 
> > diff --git a/arch/arm/mach-davinci/board-da850-evm.c b/arch/arm/mach-
> davinci/board-da850-evm.c
> > index 0149fb4..bbb3c73 100644
> > --- a/arch/arm/mach-davinci/board-da850-evm.c
> > +++ b/arch/arm/mach-davinci/board-da850-evm.c
> [...]
> > @@ -1046,21 +1046,19 @@ static int __init da850_evm_config_emac(void)
> >  	}
> >
> >  	if (ret)
> > -		pr_warning("da850_evm_init: cpgmac/rmii mux setup failed:
> %d\n",
> > -				ret);
> > +		pr_warn("%s: cpgmac/rmii mux setup failed: %d\n",
> > +			__func__, ret);
> >
> >  	/* configure the CFGCHIP3 register for RMII or MII */
> >  	__raw_writel(val, cfg_chip3_base);
> >
> >  	ret = davinci_cfg_reg(DA850_GPIO2_6);
> >  	if (ret)
> > -		pr_warning("da850_evm_init:GPIO(2,6) mux setup "
> > -							"failed\n");
> > +		pr_warn("%s:GPIO(2,6) mux setup failed\n", __func__);
> 
>     Worth inserting space after colon here.

Will do.

> 
> WBR, Sergei

Thanks & Regards,

- Rob
