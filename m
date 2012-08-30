From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 30 Aug 2012 16:30:55 -0700
Subject: [PATCH 5/6] ARM: integrator: convert AMBA devices to device tree
In-Reply-To: <20120820080210.GF7439@game.jcrosoft.org>
References: <1345119373-22774-1-git-send-email-linus.walleij@linaro.org>
 <20120816124002.GB7439@game.jcrosoft.org>
 <CACRpkdZDMxk30YTkrumRveR3OuWptSpzNevrAvC2FxYShOZp-A@mail.gmail.com>
 <20120820080210.GF7439@game.jcrosoft.org>
Message-ID: <CACRpkdYkfgY-dYD1L3_HkhFJL49d9GaSWd8ax2Rqm3BGFFHhdQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Aug 20, 2012 at 1:02 AM, Jean-Christophe PLAGNIOL-VILLARD
<plagnioj@jcrosoft.com> wrote:
> On 00:42 Sun 19 Aug     , Linus Walleij wrote:

> no I mean why
>> >> +     OF_DEV_AUXDATA("arm,primecell", INTEGRATOR_RTC_BASE,
>> >> +             "rtc", NULL),
>> >> +     OF_DEV_AUXDATA("arm,primecell", KMI0_BASE,
>> >> +             "kmi0", NULL),
>> >> +     OF_DEV_AUXDATA("arm,primecell", KMI1_BASE,
>> >> +             "kmi1", NULL),
>
> no platform data why do you use the AUXDATA?
>
> as the OF_DEV_AUXDATA is deprecated now

OK this is to get the right bus names of the devices.

As I support boot from both device tree and without device tree, I cannot
change all the names that e.g. the clock framework is tied to.

Once we switch to pure device tree this can be changed at the user
sites and all auxdata be removed.

Yours,
Linus Walleij
