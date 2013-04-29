From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 29 Apr 2013 13:59:39 -0600
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
Message-ID: <517ED12B.8080502@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/29/13 12:41, Bryan Wu wrote:
> Forward to ARM and Tegra mail list.
>
> ---------- Forwarded message ----------
> From: Bryan Wu <cooloney@gmail.com>
> Date: Mon, Apr 29, 2013 at 11:15 AM
> Subject: Tegra 30 System hangs because of commit "pinctrl: move
> subsystem mutex to pinctrl_dev struct"
> To: patrice.chotard at st.com, Linus Walleij <linus.walleij@linaro.org>
> Cc: Stephen Warren <swarren@wwwdotorg.org>,
> "linux-next at vger.kernel.org" <linux-next@vger.kernel.org>
>
>
> Hi Patrice and Linus,
>
> I'm running linux-next on my Tegra 30 system everyday. But since
> next-20130426 release, the linux-next kernel will hang on my Tegra 30
> boards like Cardhu and Beaver.
>
> After some bisect and comparing to next-20130424, I found the commit
> "pinctrl: move subsystem mutex to pinctrl_dev struct" introduced this
> issue. If I simply revert this patch in next-20130429, system boots up
> as before.
>
> Could you please help to check this?

I would suggest simply dropping or reverting this patch; I had pointed 
out a long time ago that it was unlikely to be correct.

My guess/suspicion is a recursive lock attempt during processing hogs 
during pinctrl device registration, or perhaps during dt->map 
conversion. Bryan, are you able to confirm this?
