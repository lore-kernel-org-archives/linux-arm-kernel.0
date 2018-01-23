From: tony@atomide.com (Tony Lindgren)
Date: Tue, 23 Jan 2018 09:45:19 -0800
Subject: [PATCH] pinctrl: pinctrl-single: Fix pcs_request_gpio() when
 bits_per_mux != 0
In-Reply-To: <CAHp75VetRjLioS1zAubZshggKTiWJ-KJ+HjTSkoK=6LVP6SY2g@mail.gmail.com>
References: <1516575793-30526-1-git-send-email-david@lechnology.com>
 <CAHp75VdkShHhxL+3PyaPEC2Dyr8aWoEH8CQk+bEJ2WD4i6ojHg@mail.gmail.com>
 <d1426fbc-bc82-89cd-d08d-242b16d2c99d@lechnology.com>
 <CAHp75VetRjLioS1zAubZshggKTiWJ-KJ+HjTSkoK=6LVP6SY2g@mail.gmail.com>
Message-ID: <20180123174519.GF4180@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Andy Shevchenko <andy.shevchenko@gmail.com> [180123 09:25]:
> On Mon, Jan 22, 2018 at 7:06 PM, David Lechner <david@lechnology.com> wrote:
> > On 01/22/2018 08:49 AM, Andy Shevchenko wrote:
> >> On Mon, Jan 22, 2018 at 1:03 AM, David Lechner <david@lechnology.com>
> >> wrote:
> 
> >>> Fixes: 4e7e8017a80e ("pinctrl: pinctrl-single: enhance to configure
> >>> multiple pins of different modules")
> 
> >> One line?
> 
> > One line is more important that wrapping to 75 chars?
> 
> It's *special* line, i.e. tag. Tag per line is a rule I know, did I
> miss any new change to that?

I think the rule for merge commits is to try to limit them to 75
characters for git log.

> >>> +                       byte_num = (pcs->bits_per_pin * pin) /
> >>> BITS_PER_BYTE;
> >>> +                       offset = (byte_num / mux_bytes) * mux_bytes;
> >>> +                       pin_shift = pin % (pcs->width /
> >>> pcs->bits_per_pin) *
> >>> +                                   pcs->bits_per_pin;
> 
> >> Sounds like playing around pretty well defined macro and functions,
> >> e.g. DIV_ROUND_UP(), round_up().
> 
> > I admit, I just copied existing code (which may be a reason to leave this
> > the
> > way it is).
> 
> Ah, fair enough.
> 
> >  But, I only see once place to do this:
> >
> >         offset = round_down(byte_num, mux_bytes);
> >
> > Did I miss another?
> 
> I meant that you may use macros to make code cleaner. Though, taking
> above into consideration, it would be done as a separate patch later.

Yeah makes sense to me to do them separately. It would be good to
get Haojian's ack or tested-by on this one, I don't think I have
hardware where I can test the GPIO features with this driver.

Regards,

Tony
