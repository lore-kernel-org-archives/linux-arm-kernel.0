From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 9 Jan 2015 11:53:37 +0000
Subject: [PATCH 5/9] dts: versatile: add sysregs nodes
In-Reply-To: <CACRpkdZFxToT5L0sJXap-NQGtjkryn4KTZVnweKCxXL9WvFLEg@mail.gmail.com>
References: <1419967718-26909-1-git-send-email-robherring2@gmail.com>
 <1419967718-26909-6-git-send-email-robherring2@gmail.com>
 <CACRpkdbinR3Uvi5zZmQJFxJgnWfvE6JZouMVxxRRGVtMNXkBQQ@mail.gmail.com>
 <CAL_JsqKBLx03E1w0NMH8CH+Pm_L8yQvnR6VTTDxqnpOwAoDhXg@mail.gmail.com>
 <CACRpkdZFxToT5L0sJXap-NQGtjkryn4KTZVnweKCxXL9WvFLEg@mail.gmail.com>
Message-ID: <20150109115337.GA18609@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Cc'ing Pawel since he wrote the sysreg code

On Fri, Jan 09, 2015 at 07:10:36AM +0000, Linus Walleij wrote:
> On Fri, Jan 9, 2015 at 12:53 AM, Rob Herring <robherring2@gmail.com> wrote:
> > On Thu, Jan 8, 2015 at 1:44 PM, Linus Walleij <linus.walleij@linaro.org> wrote:
> 
> >> On Tue, Dec 30, 2014 at 8:28 PM, Rob Herring <robherring2@gmail.com> wrote:
> >> compatible = "syscon";
> >
> > maybe? VExpress is missing that then...
> 
> I don't like the way some vexpress stuff has been done I think, just
> not enough reviewing power :(

I think that "syscon" is not meant to be there in the first place and it
was done on purpose for vexpress but I need Pawel to confirm and shed
light on this.

> I've tried to make an as clean separation as possible in the Integrator
> as it has been refactored with a minimum of time pressure and
> I tried to make it as reusable as possible. But it doesn't necessarily
> mean I did the right thing all the time ...
> 
> >>> +                               reg = <0x00000 0x1000>;
> >>> +
> >>> +                               v2m_led_gpios: sys_led at 08 {
> >>> +                                       compatible = "arm,vexpress-sysreg,sys_led";
> >>> +                                       gpio-controller;
> >>> +                                       #gpio-cells = <2>;
> >>> +                               };
> >>
> >> These are not GPIOs. These are LED registers really.
> >
> > A register bit that controls an i/o signal sounds like a GPIO to me.
> 
> Are they described as general purpose in the manual for the
> board?
> 
> In the ARM reference design manuals I've seen these bits are
> described as for one purpose only. I mean you can claim the
> memory RE signal is "a bit that controls an I/O signal" as well,
> but we have to think about the abstraction here.

I will have a look into this.

Thanks,
Lorenzo
