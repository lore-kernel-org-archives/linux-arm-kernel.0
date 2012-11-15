From: rtivy@ti.com (Tivy, Robert)
Date: Thu, 15 Nov 2012 01:53:34 +0000
Subject: [PATCH v3 2/6] ARM: davinci: Changed pr_warning() to pr_warn()
 (part 2)
In-Reply-To: <50A36FA9.5050601@mvista.com>
References: <1352853207-20602-1-git-send-email-rtivy@ti.com>
 <1352853207-20602-2-git-send-email-rtivy@ti.com>
 <50A36FA9.5050601@mvista.com>
Message-ID: <13514BD7FAEBA745BBD7D8A672905C14311F2D0E@DFLE08.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Sergei,

Thanks for your feedback, please see below...

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov at mvista.com]
> Sent: Wednesday, November 14, 2012 2:17 AM
> To: Tivy, Robert
> Cc: davinci-linux-open-source at linux.davincidsp.com; linux-arm-
> kernel at lists.infradead.org; Ring, Chris; Grosen, Mark; Nori, Sekhar
> Subject: Re: [PATCH v3 2/6] ARM: davinci: Changed pr_warning() to
> pr_warn() (part 2)
> 
> Hello.
> 
> On 14-11-2012 4:33, Robert Tivy wrote:
> 
> > Also, while modifying those pr_warning() calls I changed hardcoded
> > function names to use '"%s:", __func__' instead
> 
> > Signed-off-by: Robert Tivy <rtivy@ti.com>
> > ---
> > Clean up files that will be otherwise modified in subsequent patch.
> 
> > Applies to v3.7-rc2 tag (commit
> > 6f0c0580b70c89094b3422ba81118c7b959c7556) of Linus' mainline kernel
> at git.kernel.org.
> 
> >   arch/arm/mach-davinci/board-omapl138-hawk.c |   30 ++++++++++------
> -----------
> >   1 file changed, 11 insertions(+), 19 deletions(-)
> 
>     Taksing of separation of board and SoC specific changes, this patch
> shouldn't have been separated from patch 1 at all -- since it's two
> boards built around the same chip, OMAP-L138...

The 4 patches that are of the same nature ("Changed pr_warning() to pr_warn() (part #)") were split as 4 separate patches on request by Sekhar, for the purpose of making it easier to merge later.

> 
> > diff --git a/arch/arm/mach-davinci/board-omapl138-hawk.c
> > b/arch/arm/mach-davinci/board-omapl138-hawk.c
> > index dc1208e..8aea169 100644
> > --- a/arch/arm/mach-davinci/board-omapl138-hawk.c
> > +++ b/arch/arm/mach-davinci/board-omapl138-hawk.c
> > @@ -48,8 +48,7 @@ static __init void omapl138_hawk_config_emac(void)
> >   	val &= ~BIT(8);
> >   	ret = davinci_cfg_reg_list(omapl138_hawk_mii_pins);
> >   	if (ret) {
> > -		pr_warning("%s: cpgmac/mii mux setup failed: %d\n",
> > -			__func__, ret);
> > +		pr_warn("%s: cpgmac/mii mux setup failed: %d\n", __func__,
> ret);
> 
>     I'd have preferred this as "CPGMAC/MII". Almost all other acronyms
> in the messages are capitalized.

I didn't originate those acronyms so I'm not inclined to change them.

Regards,

- Rob

> 
> >   		return;
> >   	}
> >
> > @@ -61,8 +60,7 @@ static __init void omapl138_hawk_config_emac(void)
> >
> >   	ret = da8xx_register_emac();
> >   	if (ret)
> > -		pr_warning("%s: emac registration failed: %d\n",
> > -			__func__, ret);
> > +		pr_warn("%s: emac registration failed: %d\n", __func__,
> ret);
> 
>     ... and "EMAC" here.
> 
> WBR, Sergei
