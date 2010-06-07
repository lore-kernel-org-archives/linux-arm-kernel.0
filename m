From: marek.vasut@gmail.com (Marek Vasut)
Date: Mon, 7 Jun 2010 23:26:09 +0200
Subject: [PATCH] pxa2xx/cpufreq: Fix DRI computation
In-Reply-To: <87bpbmocjy.fsf@free.fr>
References: <1275698808-31166-1-git-send-email-marek.vasut@gmail.com>
	<87bpbmocjy.fsf@free.fr>
Message-ID: <201006072326.09722.marek.vasut@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dne Po 7. ?ervna 2010 21:41:37 Robert Jarzmik napsal(a):
> Marek Vasut <marek.vasut@gmail.com> writes:
> > The DRI field was incorrectly computed, causing various hangs and weird
> > behaviour on PXA2xx machines. This patch introduces the DRI computation
> > according to the PXA255 (January 2004) and PXA270 (MV-S301039-00 Rev. A)
> > datasheets.
> 
> Hi Marek,
> 
> I'll help a bit in the review here, but I need a few days.
> 
> Meanwhile, I began the review and I have a question : did you check
> MDCNFG_DRAC0() and MDCNFG_DRAC2() definitions ? As I check my TRM, it
> should be, according to my manual :
> + #define MDCNFG_DRAC2(mdcnfg) (((mdcnfg) >> 19) & 0x3)
> + #define MDCNFG_DRAC0(mdcnfg) (((mdcnfg) >> 3) & 0x3)
> - #define MDCNFG_DRAC2(mdcnfg) (((mdcnfg) >> 21) & 0x3)
> - #define MDCNFG_DRAC0(mdcnfg) (((mdcnfg) >> 5) & 0x3)
> 
> While I was checking the calculation, that rows calculation doesn't fit.
> Hence I wonder if init_sdram_rows() will be correct.
> I'll send a full review soon, don't be too quick with V2 please.
> 

No actually, the definitions are correct. I just looked and what you are looking 
at is DCAC, not DRAC. Cheers
> Cheers.
> 
> --
> Robert
