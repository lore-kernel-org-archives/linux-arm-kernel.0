From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 4 Jun 2015 14:14:16 +0200
Subject: [PATCH v4] arm: tcm: Don't crash when TCM banks are protected by
 TrustZone
In-Reply-To: <1433419121-18726-1-git-send-email-michael@smart-africa.com>
References: <1433257803-25318-1-git-send-email-michael@smart-africa.com>
 <1433419121-18726-1-git-send-email-michael@smart-africa.com>
Message-ID: <CACRpkdbHhjtmUKhAyw15SGNA-2XbyTGV3=8M116VfL6Wv1c8BA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 4, 2015 at 1:58 PM, Michael van der Westhuizen
<michael@smart-africa.com> wrote:

> Fixes the TCM initialisation code to handle TCM banks that are
> present but inaccessible due to TrustZone configuration.  This is
> the default case when enabling the non-secure world.  It may also
> be the case that that the user decided to use TCM for TrustZone.
>
> This change has exposed a bug in handling of TCM where no TCM bank
> was usable (the 0 size TCM case).  This change addresses the
> resulting hang.
>
> This code only handles the ARMv6 TCMTR register format, and will not
> work correctly on boards that use the ARMv7 (or any other) format.
> This is handled by performing an early exit from the initialisation
> function when the TCMTR reports any format other than v6.
>
> Signed-off-by: Michael van der Westhuizen <michael@smart-africa.com>
> Cc: Linus Walleij <linus.walleij@linaro.org>
> Cc: Russell King <rmk+kernel@arm.linux.org.uk>
> Cc: Dave Martin <Dave.Martin@arm.com>
> ---
>
> Changes in v4:
>   - Clarify that the instruction encoding for unconditional MRC
>     happens to be identical between ARM and Thumb-2 modes.

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

If no further comment appear, I suggest you put this into Russell's
patch tracker.

Yours,
Linus Walleij
