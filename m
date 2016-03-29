From: jonas.rabenstein@studium.uni-erlangen.de (Jonas Rabenstein)
Date: Tue, 29 Mar 2016 10:29:11 +0200
Subject: [PATCH] arm: remove tautologic #ifdefs in proc-v7-3level.S
In-Reply-To: <3570872.7QPkonuD2y@wuerfel>
References: <1459237071-13842-1-git-send-email-jonas.rabenstein@studium.uni-erlangen.de>
 <3570872.7QPkonuD2y@wuerfel>
Message-ID: <20160329082911.GG20211@studium.uni-erlangen.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 29, 2016 at 10:05:58AM +0200, Arnd Bergmann wrote:
> On Tuesday 29 March 2016 09:37:51 Jonas Rabenstein wrote:
> > The file arch/arm/mm/proc-v7-3level.S is only used by the #include
> > directive in arch/arm/mm/proc-v7.S:23. This #include is conditional and
> > depends on  CONFIG_ARM_LPAE (otherwise proc-v7-2level.S is used).
> > CONFIG_ARM_LPAE has a dependency on CONFIG_MMU defined in Kconfig.
> > Consequently, checks for CONFIG_MMU in proc-v7-3level.S are superfluous.
> > 
> > Signed-off-by: Jonas Rabenstein <jonas.rabenstein@studium.uni-erlangen.de>
> > ---
> >  I detected the issue with chimaera, a tool I currently develop for my bachelor
> >  thesis extending the undertaker tool suite (https://undertaker.cs.fau.de).
> 
> Nice catch!
> 
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>
> 
> I guess you should submit the same thing for the other file as well,
> either in the same patch or as a series.
I do not get, what you mean with 'the other file'? For the
proc-v7-2level.S this precondition does not hold, as proc-v7-2level.S is
included if !CONFIG_ARM_LPAE. Consequently, no evidence about the MMU
state is available in their.

> You can also add
> 
> Fixes: 8d2cd3a38fd6 ("ARM: LPAE: Factor out classic-MMU specific code into proc-v7-2level.S")
Shouldn't it be:
Fixes: 1b6ba46b7efa ("ARM: LPAE: MMU setup for the 3-level page table
format")?

Thanks for your help and advice,
 Jonas
