From: mikpe@it.uu.se (Mikael Pettersson)
Date: Fri, 13 Sep 2013 18:07:11 +0200
Subject: [PATCH 0/8] IOP GPIO refactoring
In-Reply-To: <CACRpkdYbHTF0XGu-wLAeaw-nnSTEPh-ej9iizMbojmB8gzvb=Q@mail.gmail.com>
References: <1378741198-12847-1-git-send-email-linus.walleij@linaro.org>
 <20130910141434.GD3379@blackmetal.musicnaut.iki.fi>
 <CACRpkdYbHTF0XGu-wLAeaw-nnSTEPh-ej9iizMbojmB8gzvb=Q@mail.gmail.com>
Message-ID: <21043.14383.656033.487010@pilspetsen.it.uu.se>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Linus Walleij writes:
 > On Tue, Sep 10, 2013 at 4:14 PM, Aaro Koskinen <aaro.koskinen@iki.fi> wrote:
 > 
 > > With patch 6 it starts to crash on first gpio_get_value(), I guess
 > > because gpio-iop platform device is not registered on N2100...?
 > 
 > I think I've fixed this with the v2 versions of patches 1-3, you can
 > pull in and test the entire stack on Torvalds HEAD from here:
 > 
 > git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-gpio.git iop-cleanup

At first I tested the v3 patch kit (1/8 v2, 2/8 v3, 3/8 v2, 4/8-8/8 v1) on top
of 3.11, but that oopsed with a near-NULL defererence due to what looked like a
timer rearm before the gpio stuff was initialized.  Then I tried the above git
as of half an hour ago and it booted fine on my n2100, even pressing the power
button worked w/o issues.

So I guess you can add

Tested-by: Mikael Pettersson <mikpe@it.uu.se>

to what's in that repo above.
