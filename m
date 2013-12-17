From: bjorn.andersson@sonymobile.com (Bjorn Andersson)
Date: Mon, 16 Dec 2013 16:18:43 -0800
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <CACRpkdY2BExGiL6HBg7zn_szJQMnSNsxOSuo7RyrRmrz=cVe2A@mail.gmail.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-4-git-send-email-syin@broadcom.com>
 <CACRpkdauqYNiby-ta3c_he2ovG__0e6ubmzZ8Bx1cP_OzK4=LQ@mail.gmail.com>
 <CAEPRUYpsp_FVobY_DeEQU2+rCD7q7T=p7k++XvG-22x-OWHY8Q@mail.gmail.com>
 <CACRpkdY2BExGiL6HBg7zn_szJQMnSNsxOSuo7RyrRmrz=cVe2A@mail.gmail.com>
Message-ID: <20131217001842.GB3840@sonymobile.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon 16 Dec 02:01 PST 2013, Linus Walleij wrote:

> On Thu, Dec 12, 2013 at 10:35 PM, Christian Daudt <bcm@fixthebug.org> wrote:
> 
> >  I had requested this from Sherman. The reason is so that pinctrl can
> > be selectable through defconfig, instead of through SoC select
> > statements. And the reason for that is so that, in the future, some of
> > these can be switched into loadable modules (which can't be done from
> > Kconfig). This will become necessary with the move to multiplatform -
> > we won't be able to have everything static anymore.
> 
> Isn't it sufficient to make the pin controller entry tristate rather
> than bool?
> 
> And as mentioned elsewhere this does not at all solve the issue
> that we still need to have all basic IRQchips and timer drivers
> compiled into the kernel.

No matter how we build the individual pinctrl drivers we will always
need the pinctrl framework in a multi-soc zImage; so I can't see that
we gain anything from being able to compile PINCTRL as a module.

I don't like compiling the individual pinctrl drivers as modules, as
it leaves us with a waterfall of PROBE_DEFERRs.

Regards,
Bjorn
