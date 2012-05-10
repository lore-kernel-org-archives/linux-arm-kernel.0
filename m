From: shawn.guo@linaro.org (Shawn Guo)
Date: Thu, 10 May 2012 15:55:33 +0800
Subject: [GIT PULL] mxs: device tree support for v3.5
In-Reply-To: <CAOesGMgzs40fBMrYseT3RC0F_7paWiBKSZ8yVU=hCkFf02Q94w@mail.gmail.com>
References: <20120405013556.GI7264@S2101-09.ap.freescale.net>
 <CAOesGMjrJe++s-tmgzs2oY1T9GVntngV71-2iqZhfWx2EiZL_g@mail.gmail.com>
 <20120507135451.GI19389@S2101-09.ap.freescale.net>
 <CAOesGMgzs40fBMrYseT3RC0F_7paWiBKSZ8yVU=hCkFf02Q94w@mail.gmail.com>
Message-ID: <CAAQ0ZWQ9M+fk5dtWxLCK7OWf6kmPC_3-55kkH4v5EsMh9pzA+w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 10 May 2012 15:17, Olof Johansson <olof@lixom.net> wrote:
> Hrm. It would have probably been better to base the pinctrl and clk
> work on top of this, since we tend to order the dt work before much of
> the other topic branches.
>
It will be hard to do.  Device tree support naturally depends on
pinctrl support.  Pinctrl is actually a blocker for many platforms to
be converted over to DT.  I'm supporting pinctrl for mach-mxs from the
beginning we move to DT, and those mxs drivers have to be based on
pinctrl to have their pins defined in DT to work.

>From my experience on DT migration, the clock file will constantly be
touched to change/add clk lookup.  It's hard to tell that there will
no further DT support touching clock when we convert clock to common
clk at some point.  I think it will be easier to have DT based on
common clk series.

> Anyway, I've rebuilt next/dt without this branch now. I will temporary
> just revert the merge in for-next until it's rebuilt next time.
>
Thanks, Olof.

Regards,
Shawn
