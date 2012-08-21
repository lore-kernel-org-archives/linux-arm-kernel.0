From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 21 Aug 2012 14:46:59 +0200
Subject: [PATCH] pinctrl: imx5: start numbering pad from 0
In-Reply-To: <20120816033006.GA11999@shlinux2.ap.freescale.net>
References: <1344869278-27334-1-git-send-email-shawn.guo@linaro.org>
 <CAKGA1b=DqyZvSre3C4YQ3GM6RuFtFsGWDkF784iKggrNzwiKpg@mail.gmail.com>
 <CAP1dx+zQvBurT9oCmfJ0dGHHV3rbgdy+0Yh_hoPL9jQB8QNxKw@mail.gmail.com>
 <CAKGA1bmHqyDGyvZjEcQ+RO1jHiZNZKNu3BGkyUXzYfwVaySYEQ@mail.gmail.com>
 <CAP1dx+x0_j_f3Pj+9+YHcwoTqjGLXouf7t+SoCCMVGKJNOHCPw@mail.gmail.com>
 <20120815054436.GK2232@pengutronix.de>
 <20120815065526.GG19681@shlinux2.ap.freescale.net>
 <20120815075117.GL2232@pengutronix.de>
 <20120815092539.GH19681@shlinux2.ap.freescale.net>
 <20120815135947.GC2258@S2101-09.ap.freescale.net>
 <20120816033006.GA11999@shlinux2.ap.freescale.net>
Message-ID: <CACRpkdaKUt2UFrcRH41dFMxTVcN-Z2yqPKnc1r_O56+tcaiL5w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 16, 2012 at 5:30 AM, Dong Aisheng <b29396@freescale.com> wrote:

> The problem is that those pins are visible to pinctrl subystem, but the pinctrl
> subsystem can not manage them all.
> Not sure this meet Linus's original design purpose.

The U300 driver has *lots* of pins it cannot manage. I have no strong
opinions on this, often if there are lots of pins and say some ranges
here and there are controllable, you may want to register them all
(with names) just so that you can get something intuitive out of the
pin numbers.

But the descriptors are actually sparse, so you don't have to have
a consecutive pin range and can actually just register the pins you
want with the names you want. It's your pick...

> But i'm not sure if we may have this requirement in the future.
> For example, is it possible that pinctrl subsystem may support configure pins
> via sysfs dynamically?

Not sysfs. For GPIO this ended up in a bad place.
Maybe /dev/pinctrl0, /dev/pinctrl1

But I don't think we want to expose individual pin configs to
userspace. Maybe pinctrl states. Dunno, has to be designed,
and surely pins can be totally numb and unconfigurable as well....

> If it supports, will imx driver also support config unused pins in devicetree
> via sysfs?

DT *or* /dev/foo I guess.

Yours,
Linus Walleij
