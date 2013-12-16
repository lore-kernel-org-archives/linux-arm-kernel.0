From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Dec 2013 11:01:17 +0100
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <CAEPRUYpsp_FVobY_DeEQU2+rCD7q7T=p7k++XvG-22x-OWHY8Q@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-4-git-send-email-syin@broadcom.com>
 <CACRpkdauqYNiby-ta3c_he2ovG__0e6ubmzZ8Bx1cP_OzK4=LQ@mail.gmail.com>
 <CAEPRUYpsp_FVobY_DeEQU2+rCD7q7T=p7k++XvG-22x-OWHY8Q@mail.gmail.com>
Message-ID: <CACRpkdY2BExGiL6HBg7zn_szJQMnSNsxOSuo7RyrRmrz=cVe2A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 10:35 PM, Christian Daudt <bcm@fixthebug.org> wrote:

>  I had requested this from Sherman. The reason is so that pinctrl can
> be selectable through defconfig, instead of through SoC select
> statements. And the reason for that is so that, in the future, some of
> these can be switched into loadable modules (which can't be done from
> Kconfig). This will become necessary with the move to multiplatform -
> we won't be able to have everything static anymore.

Isn't it sufficient to make the pin controller entry tristate rather
than bool?

And as mentioned elsewhere this does not at all solve the issue
that we still need to have all basic IRQchips and timer drivers
compiled into the kernel.

Yours,
Linus Walleij
