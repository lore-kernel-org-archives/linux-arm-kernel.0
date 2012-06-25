From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 26 Jun 2012 02:46:57 +0800
Subject: [PATCH] serial/amba-pl011: move custom pin control to driver
In-Reply-To: <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
References: <1337800726-4076-1-git-send-email-linus.walleij@stericsson.com>
 <CAOh2x==OPVVLeKxCT0mkYX3NmOjGQRcsSY=GHCaHEJfy6wOg3Q@mail.gmail.com>
Message-ID: <CACRpkdb9=m7Qiv+hQy3sDYAQNO5+_y5fW=av0-eW589qjL5TxQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 25, 2012 at 7:31 PM, viresh kumar <viresh.kumar@linaro.org> wrote:

> People testing SPEAr with v3.5-rc1 saw that serial devices don't show
> up during boot and they
> actually return with error from this point, after Shawn's last patch.
> That will still happen with
> this patch i believe.
>
> What is expected from Platforms to handle this? AFAICR, we haven't
> done anything special
> to bind a pinctrl node to a struct dev for uart.

Yeah as Fabio pointed out, activate dummies is the quick
fix.

The "real" fix is to provide atleast a default pin map table
entry (sleep is not needed).

However I think you could benefit from using this on
SPEAr by providing two different pinconf lists for
the default and sleep modes as the ux500 does:
usually this saves some power.

Yours,
Linus Walleij
