From: linus.walleij@linaro.org (Linus Walleij)
Date: Fri, 20 Dec 2013 10:37:51 +0100
Subject: [PATCH v3 3/6] pinctrl: Make PINCTRL selectable by
 defconfig/menuconfig
In-Reply-To: <20131217001842.GB3840@sonymobile.com>
References: <1381174108-25168-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1386787041-6035-4-git-send-email-syin@broadcom.com>
 <CACRpkdauqYNiby-ta3c_he2ovG__0e6ubmzZ8Bx1cP_OzK4=LQ@mail.gmail.com>
 <CAEPRUYpsp_FVobY_DeEQU2+rCD7q7T=p7k++XvG-22x-OWHY8Q@mail.gmail.com>
 <CACRpkdY2BExGiL6HBg7zn_szJQMnSNsxOSuo7RyrRmrz=cVe2A@mail.gmail.com>
 <20131217001842.GB3840@sonymobile.com>
Message-ID: <CACRpkdY-MM7OoMq_L90YRADy=oaDoV1wAOccVz90LqfRfEh=3Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 17, 2013 at 1:18 AM, Bjorn Andersson
<bjorn.andersson@sonymobile.com> wrote:

> No matter how we build the individual pinctrl drivers we will always
> need the pinctrl framework in a multi-soc zImage; so I can't see that
> we gain anything from being able to compile PINCTRL as a module.

I discussed this matter with Christian on IRC and I believe we could
basically do "select PINCTRL" on ARCH_MULTIPLATFORM as the
vast majority of multiplatforms appear to be using this anyway, this
would make the submenu for pin control pop up in menuconfig
for this, and make it possible to move different subdrivers to modules
if desired.

MULTIPLATFORM does not seem to be about saving footprint bytes
on a very fine-granular level anyway, more about doing the module
loading/unloading approach to footprint.

(That drivers such as clk, regulator, pin control, GPIO, irqchip are
usually impossible to rmmod as their tentacles will invariably be
in all drivers everywhere is another issue, but this approach will solve
modular *loading* atleast.)

Yours,
Linus Walleij
