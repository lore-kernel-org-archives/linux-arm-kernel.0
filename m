From: thierry.reding@gmail.com (Thierry Reding)
Date: Wed, 20 Aug 2014 08:09:04 +0200
Subject: [PATCH 2/4] pwm: rockchip: Allow polarity invert on rk3288
In-Reply-To: <CAD=FV=Uvx3PMJRdnm4FKWWx4h3sN0Mn1yG6v245HnKur_3vgqQ@mail.gmail.com>
References: <1408381749-14156-1-git-send-email-dianders@chromium.org>
 <1408381749-14156-3-git-send-email-dianders@chromium.org>
 <20140819071857.GD12859@ulmo>
 <CAD=FV=Uvx3PMJRdnm4FKWWx4h3sN0Mn1yG6v245HnKur_3vgqQ@mail.gmail.com>
Message-ID: <20140820060903.GE13793@ulmo>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 19, 2014 at 09:05:20AM -0700, Doug Anderson wrote:
> On Tue, Aug 19, 2014 at 12:18 AM, Thierry Reding <thierry.reding@gmail.com> wrote:
> > On Mon, Aug 18, 2014 at 10:09:07AM -0700, Doug Anderson wrote:
[...]
> >> @@ -74,10 +78,14 @@ static void rockchip_pwm_set_enable_v2(struct pwm_chip *chip, bool enable)
> >>  {
> >>       struct rockchip_pwm_chip *pc = to_rockchip_pwm_chip(chip);
> >>       u32 enable_conf = PWM_OUTPUT_LEFT | PWM_LP_DISABLE | PWM_ENABLE |
> >> -                       PWM_CONTINUOUS | PWM_DUTY_POSITIVE |
> >> -                       PWM_INACTIVE_NEGATIVE;
> >> +                       PWM_CONTINUOUS;
> >>       u32 val;
> >>
> >> +     if (pc->polarity == PWM_POLARITY_INVERSED)
> >> +             enable_conf |= PWM_DUTY_NEGATIVE | PWM_INACTIVE_POSITIVE;
> >> +     else
> >> +             enable_conf |= PWM_DUTY_POSITIVE | PWM_INACTIVE_NEGATIVE;
> >
> > I have a feeling you're going to answer the above question with: "Because
> > it's needed here". If so, my reply would be: "Then this function should
> > take a struct pwm_device instead of struct pwm_chip."
> 
> OK.  I've chosen to have it take a pwm_device AND a pwm_chip.  It is a
> little redundant because a pwm_device has a pointer to its pwm_chip,
> but it follows the lead of all of the callbacks in "struct pwm_ops".
> If you'd like me to spin it to take only a pwm_device I'm happy to.

No, that's fine.

Thierry
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140820/387c5e48/attachment.sig>
