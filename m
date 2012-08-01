From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 1 Aug 2012 14:32:01 +0000
Subject: [PATCH 5/6] ARM: ux500: Ensure probing of Audio devices when
 Device Tree is enabled
In-Reply-To: <5019356E.6020407@linaro.org>
References: <1343741493-17671-1-git-send-email-lee.jones@linaro.org>
 <201208011332.02500.arnd@arndb.de> <5019356E.6020407@linaro.org>
Message-ID: <201208011432.02398.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 01 August 2012, Lee Jones wrote:
> 
> On 01/08/12 14:32, Arnd Bergmann wrote:
> > On Wednesday 01 August 2012, Lee Jones wrote:
> >>> Looks like you're adding the same call to each of the three cases:
> >>> mop500, snowball and hrefv60+. How about moving it before or after
> >>> the if/elseif block?
> >>
> >> The Snowball one is different 'mop500_msp_init' -> 'mop500_of_msp_init'.
> >
> > Ah, I see. Is there a problem in always using mop500_of_msp_init then?
> > I would guess that this just means you'd have to put the msp into the
> > device tree files, which don't yet exist for mop500 and hrefv60.
> 
> Although that is true, it's only part of the issue.
> 
> mop500_of_msp_init is only a temporary solution to aid in step-by-step 
> enablement of DT for audio. By the end of the patch-set it has been 
> removed (along with the call to it if 'of_machine_is_compatible 
> ("calaosystems,snowball-a9500")'. What I can do it write a patch to 
> consolidate the calls after "ARM: ux500: Remove platform registration 
> of MSP devices", as a bolt-on.

I see. Your solution looks fine then.

	Arnd
