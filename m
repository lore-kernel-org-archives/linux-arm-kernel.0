From: lethal@linux-sh.org (Paul Mundt)
Date: Wed, 20 Jun 2012 23:31:41 +0900
Subject: [PATCH] GPIOLIB: add generic gpio_set_pull API
In-Reply-To: <CACRpkdazTKs_sNHVkVAYdz6CK9fwghf2n-Rrs7fi7R1Z=Gt+3w@mail.gmail.com>
References: <1312780773-23142-1-git-send-email-Baohua.Song@csr.com>
 <20110808081552.GI32513@linux-sh.org>
 <CACxGe6ssT4=kxApaKhv+=7nDcEFVW+oyByFQ_hzcfyZ4gw2C3g@mail.gmail.com>
 <CAH9JG2V-66Wn7nwJz6tOkESoQAUJzAg-47YeMY0vzwu6T9O=Rg@mail.gmail.com>
 <4E40912C.5040801@codeaurora.org>
 <CACRpkdZUxYP0Mbe+heEwrZE5VC+J42g_-QAusrOsUuBPT324Hw@mail.gmail.com>
 <CAGsJ_4y38KBDfjZS_k-QfDUUFAtEwE-ciUgNOA0U2juOBeoXEA@mail.gmail.com>
 <CACRpkdazTKs_sNHVkVAYdz6CK9fwghf2n-Rrs7fi7R1Z=Gt+3w@mail.gmail.com>
Message-ID: <20120620143140.GA7817@linux-sh.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 20, 2012 at 10:15:01AM +0200, Linus Walleij wrote:
> On Tue, Jun 19, 2012 at 5:25 AM, Barry Song <21cnbao@gmail.com> wrote:
> > but i think at least the macros of GPIO_PULL_NONE, GPIO_PULL_UP and
> > GPIO_PULL_DOWN should be standardized.
> 
> You find an attempt at standardization in drivers/pinctrl/pinconf-generic.c
> which is also used by the composite U300+COH901 drivers. Drivers
> can select this support library and use the flags from
> <linux/pinctrl/pinconf-generic.h>
> 
What's with PIN_CONFIG_END using such an insane value?

I'm happy to consolidate on the provided definitions and add my own on top
of that, but I'm not going to waste an insane amount of bits that I could
be using for driver-specific data and so on instead to comply with the
PIN_CONFIG_END comment. Is there any valid reason why this would ever
need to exceed 4 bits?
