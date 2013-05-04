From: plagnioj@jcrosoft.com (Jean-Christophe PLAGNIOL-VILLARD)
Date: Sat, 4 May 2013 15:30:04 +0200
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <517ED12B.8080502@wwwdotorg.org>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org>
Message-ID: <20130504133004.GC24282@game.jcrosoft.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13:59 Mon 29 Apr     , Stephen Warren wrote:
> On 04/29/13 12:41, Bryan Wu wrote:
> >Forward to ARM and Tegra mail list.
> >
> >---------- Forwarded message ----------
> >From: Bryan Wu <cooloney@gmail.com>
> >Date: Mon, Apr 29, 2013 at 11:15 AM
> >Subject: Tegra 30 System hangs because of commit "pinctrl: move
> >subsystem mutex to pinctrl_dev struct"
> >To: patrice.chotard at st.com, Linus Walleij <linus.walleij@linaro.org>
> >Cc: Stephen Warren <swarren@wwwdotorg.org>,
> >"linux-next at vger.kernel.org" <linux-next@vger.kernel.org>
> >
> >
> >Hi Patrice and Linus,
> >
> >I'm running linux-next on my Tegra 30 system everyday. But since
> >next-20130426 release, the linux-next kernel will hang on my Tegra 30
> >boards like Cardhu and Beaver.
> >
> >After some bisect and comparing to next-20130424, I found the commit
> >"pinctrl: move subsystem mutex to pinctrl_dev struct" introduced this
> >issue. If I simply revert this patch in next-20130429, system boots up
> >as before.
> >
> >Could you please help to check this?
> 
> I would suggest simply dropping or reverting this patch; I had
> pointed out a long time ago that it was unlikely to be correct.
> 
> My guess/suspicion is a recursive lock attempt during processing
> hogs during pinctrl device registration, or perhaps during dt->map
> conversion. Bryan, are you able to confirm this?

same issue on at91sam9g45ek

revert it

Best Regards,
J.
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
