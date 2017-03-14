From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 14 Mar 2017 16:06:40 +0100
Subject: [PATCH] pinctrl: rockchip: add irq_enable & irq_disable ops
In-Reply-To: <CACRpkdYQawufFw+TX8MX0qbAXOy9rJ=uT5qCG8kmfOON2k7yMw@mail.gmail.com>
References: <1488434212-6567-1-git-send-email-jeffy.chen@rock-chips.com>
 <CACRpkdYQawufFw+TX8MX0qbAXOy9rJ=uT5qCG8kmfOON2k7yMw@mail.gmail.com>
Message-ID: <1586348.DzvzNKqtLI@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

Am Dienstag, 14. M?rz 2017, 16:03:48 CET schrieb Linus Walleij:
> On Thu, Mar 2, 2017 at 6:56 AM, Jeffy Chen <jeffy.chen@rock-chips.com> 
wrote:
> > Currently we are trying to enable/disable the clk of irq's gpio bank when
> > unmask/mask irq. But the kernel's "lazy disable approach" will skip
> > masking
> > irq when the irq chip doesn't support irq_disable ops.
> > 
> > So we may hit this case:
> >         irq_enable-> enable clk
> >         irq_disable-> noop
> >         irq_enable-> enable clk again
> >         irq_disable-> noop
> > 
> > Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
> 
> Heiko, can you look at this patch?

This (and all the other pending pinctrl patches) are in my queue, but right 
now I'm still hunting rockchip regressions in 4.11-rc, so haven't found the 
time to review yet.


Heiko
