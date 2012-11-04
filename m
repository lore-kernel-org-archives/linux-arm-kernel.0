From: linus.walleij@linaro.org (Linus Walleij)
Date: Sun, 4 Nov 2012 18:37:44 +0100
Subject: [PATCH v2] leds: leds-gpio: adopt pinctrl support
In-Reply-To: <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
References: <1346487390-11399-1-git-send-email-anilkumar@ti.com>
 <CACRpkdbSY-aH_Vf3Q4h-ufz35m6=vVXCEecGGS-WOsG7vmPZ0g@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3E24E@DBDE01.ent.ti.com>
 <CACRpkdZ_NxST-oJ=MWC5L=r8uQD_71eHUVUR85v4jfsYpqz=UQ@mail.gmail.com>
 <20121001154451.GI4840@atomide.com>
 <CACRpkdaib2M1_UwSbyUG8qwZC2h7xaT5VU7WMj=y+h4S4LianQ@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA3F22E@DBDE01.ent.ti.com>
 <CACRpkdaeu3JaLqSbqETT=D0mdUu5VpwRpS_Xohd6M963rw8QMg@mail.gmail.com>
 <331ABD5ECB02734CA317220B2BBEABC13EA5C598@DBDE01.ent.ti.com>
Message-ID: <CACRpkdY_db3ju4LVnoR=0Wq8TFUxa48jNFGhvGM-3uSrmGZVew@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 30, 2012 at 3:12 PM, AnilKumar, Chimata <anilkumar@ti.com> wrote:

> I completely understood this named modes, I have added named
> modes like this in am335x-xxx.dts files

I do not understand how the pinctrl-single dts files work actually,
so please get Tony to review this part.

> I think "pinctrl-1" state will be used in driver
> suspend/resume calls.

Hopefully, I think you should test the code and monitor the
system to make sure the right thing happens.

> I have the pinmux/conf settings for default state but fully
> optimized pinmux/conf values in idle & suspend states are not
> available yet.

You have defined a "sleep" state which is what should be used
for suspend? Or do you mean that you do have a state but
you're just not defining it to the most optimal setting yet?

> Even though if I add here, I am unable to test
> these pins in suspend state because suspend/resume of AM35xx
> is not added yet

Aha.

> I have two options now
> - add only default states for now, I can add reset of
> the state details once suspend/resume is supported.
> - add same values in all the states, modify those once
> suspend/resume is added for AM335x.

The OMAP maintainer gets to choose how this is to be done,
it's none of my business :-)

Yours,
Linus Walleij
