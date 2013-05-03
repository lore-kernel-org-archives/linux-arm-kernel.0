From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 3 May 2013 16:22:41 +0200
Subject: Fwd: Tegra 30 System hangs because of commit "pinctrl: move
 subsystem mutex to pinctrl_dev struct"
In-Reply-To: <517ED12B.8080502@wwwdotorg.org>
References: <CAK5ve-KXdS8az=Gtja-mF=Z3_EeZVA7bLYSU0EE2mf5bHmSUKw@mail.gmail.com>
 <CAK5ve-KBDyvjNRVMcXgfnhYcajdcGsuAKaepzCBt+epiXoYvSw@mail.gmail.com>
 <517ED12B.8080502@wwwdotorg.org>
Message-ID: <CACRpkdboCQmV_Aam3EDcSG6PRVnpEmGkC78m3h7rXT68V2a9Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 29, 2013 at 9:59 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:

> I would suggest simply dropping or reverting this patch; I had pointed out a
> long time ago that it was unlikely to be correct.
>
> My guess/suspicion is a recursive lock attempt during processing hogs during
> pinctrl device registration, or perhaps during dt->map conversion. Bryan,
> are you able to confirm this?

This was not the case at all, it was an mutex_unlock misspelled as
mutex_lock()... totally unrecursive dual locking :-)

I did test the patch quite extensively, albeit not on a system using
DT to populate the pinctrl tables so I missed this, mea culpa.

I really want to get rid of the big pinctrl lock and make this more
fine-granular, and that is why the patch is being pushed, bear
with me.

Yours,
Linus Walleij
