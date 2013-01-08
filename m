From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Jan 2013 16:53:42 +0530
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <50EC007F.1090301@nvidia.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130108094134.GA21994@gmail.com>
 <201301081044.14876.marex@denx.de>
 <201301081048.38149.marex@denx.de>
 <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
 <20130108111104.GF21994@gmail.com>
 <CAKohpomiS+UFzgiJaQbm8aZVPY0jeYhm1k7Yndk50z8=K4LvGQ@mail.gmail.com>
 <50EC007F.1090301@nvidia.com>
Message-ID: <CAKohponFeYgjC6qbNNWJ-mv0_7z=vDbZv1Bi0psBRnM5dLugxg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2013 16:48, Laxman Dewangan <ldewangan@nvidia.com> wrote:
> I think we can do it in the gpio chip driver inthe function
> xxx_gpio_irq_set_type().
> When you register any irq and if this callback is available from gpio chip
> driver then this will get called. and so the setting the pi to input mode as
> well as putting the pin in GPIO mode can be done here.  This is what we are
> doing it in gpio-tegra driver.

Hmm... So, the initial question was, is somebody setting gpio in input mode?
There were no bugs reported, it was just a query. As most of the stuff would
work as per my earlier explanation.

But yes, your suggestion makes sense too.. I would rather do it in the gpiolib
routine instead of adding this in every driver.

@Linus/Grant: What do you say?
