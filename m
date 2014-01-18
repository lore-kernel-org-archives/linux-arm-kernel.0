From: mporter@linaro.org (Matt Porter)
Date: Fri, 17 Jan 2014 21:56:00 -0500
Subject: [PATCH v4 3/4] ARM: pinctrl: Add Broadcom Capri pinctrl driver
In-Reply-To: <52D98B99.5050604@broadcom.com>
References: <1386787041-6035-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-1-git-send-email-syin@broadcom.com>
 <1387592016-13740-4-git-send-email-syin@broadcom.com>
 <CACRpkdaPZrR=kEknr3YKDWLd_E+o22Yn19ei7iT6cdbYdbeZ2w@mail.gmail.com>
 <52D98B99.5050604@broadcom.com>
Message-ID: <20140118025600.GS31049@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jan 17, 2014 at 11:59:21AM -0800, Sherman Yin wrote:
> On 14-01-16 05:19 AM, Linus Walleij wrote:
> >On Sat, Dec 21, 2013 at 3:13 AM, Sherman Yin <syin@broadcom.com> wrote:
> >
> >'> Adds pinctrl driver for Broadcom Capri (BCM281xx) SoCs.
> >>
> >>Signed-off-by: Sherman Yin <syin@broadcom.com>
> >>Reviewed-by: Christian Daudt <bcm@fixthebug.org>
> >>Reviewed-by: Matt Porter <matt.porter@linaro.org>
> >>---
> >>v4: - PINCTRL selected in Kconfig, PINCTRL_CAPRI selected in bcm_defconfig
> >>     - make use of regmap
> >>     - change CAPRI_PIN_UPDATE from macro to inline function.
> >>     - Handle pull-up strength arg in Ohm instead of enum
> >
> >Patch applied. It is really good now! It's late before the merge
> >window, but you've done a tremendous work on this driver and
> >I don't want to delay its deployment further.
> 
> Great, thanks for the support and reviews!

Very nice! Now after having completely missing something fundamental on
my reviews, I feel compelled to bring it up at the 11^H^H12th hour.

That is, this is the *only* BCM281xx driver to be named Capri, both in
the filename and driver code, but also in the binding compatible. We
didn't do that on anything else that's gone upstream to date. This
really introduces an unfortunate inconsistency as it obscures which
SoC family this binding and driver belong with.

I wonder if Linus would accept a rename at this point (too late for 3.14
presumably, but for 3.15) of s/capri/bcm281xx throughout, bcm11351 for
the compatible string, as we have for the machine compatible, and also
BCM281XX for the Kconfig option. If not, I'll survive, but it pains me
to see one thing completely different out of this entire family. If
nothing else, it would be great to address the compatible string before
this hits the 3.14 release.

Linus?

-Matt
