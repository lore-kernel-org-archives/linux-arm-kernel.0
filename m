From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 4 Sep 2012 08:44:16 +0200
Subject: [PATCH 4/4 v3] ARM: ks8695: convert to generic time and
 clocksource
In-Reply-To: <504587C3.9040201@snapgear.com>
References: <1346700644-19352-1-git-send-email-linus.walleij@linaro.org>
 <504587C3.9040201@snapgear.com>
Message-ID: <CACRpkdZ36r=mnKjYdqxd-aya2zO7UpLFea95hJxb58Z=YVifxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 4, 2012 at 6:46 AM, Greg Ungerer <gerg@snapgear.com> wrote:

> Despite what the old code had, reading the T0TC (or the T0PD) does not
> return the current count. It just returns what you set it too.

Aha!

> As far
> as I can tell there is no programmer access to the clocks internal
> counter on the KS8695. The data sheet doesn't seem to indicate any way to
> access it.

Hm, yeah the datasheet doesn't quite tell what is read back from
that register, strange about the old code though, it's coded as if
it could be read back :-/

> If I disable the clocksource_mmio_init section of code above then I get
> working time again. I suspect that is as good as we can get on the
> K8695.

OK let me provide a patch that just does clocksource then.
Let's just fall back to jiffies.

Yours,
Linus Walleij
