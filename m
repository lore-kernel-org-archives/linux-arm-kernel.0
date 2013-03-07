From: tony@atomide.com (Tony Lindgren)
Date: Thu, 7 Mar 2013 08:36:32 -0800
Subject: [PATCH] pinctrl: single: avoid to set read only object
In-Reply-To: <CAD6h2NQNhDQfmcUih7Xs9+J8PFiRrHpTAUZb5B0+35bc6bu54w@mail.gmail.com>
References: <1362322904-19570-1-git-send-email-haojian.zhuang@linaro.org>
 <CACRpkdb-PP+BPhYZhLPnuuww5Lg2YevgvviZP4mS4XpGHAi8og@mail.gmail.com>
 <CAD6h2NQNhDQfmcUih7Xs9+J8PFiRrHpTAUZb5B0+35bc6bu54w@mail.gmail.com>
Message-ID: <20130307163631.GA11806@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Haojian Zhuang <haojian.zhuang@linaro.org> [130307 07:42]:
> On 7 March 2013 15:48, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Sun, Mar 3, 2013 at 4:01 PM, Haojian Zhuang
> > <haojian.zhuang@linaro.org> wrote:
> >
> >> drivers/pinctrl/pinctrl-single.c:1441:3: error: assignment of member
> >> ?is_generic? in read-only object
> >> make[2]: *** [drivers/pinctrl/pinctrl-single.o] Error 1
> >>
> >> Since pcs_pinconf_ops is changed to read only structure, probe()
> >> function can't set is_generic variable any more. So append new
> >> pcs_pinconf_generic_ops.
> >>
> >> Signed-off-by: Haojian Zhuang <haojian.zhuang@linaro.org>
> >
> > Isn't this fixed by Axel's much simpler patch?
> 
> Yes, I prefer to use Axel's fix.

Yes that's better.

Tony
