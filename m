From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 02 Mar 2016 16:28:54 +0100
Subject: [PATCH 3/3] ARM: dts: NSP: Add PWM Support to DT
In-Reply-To: <CAL2FKYkoXFm_pG6inxJqwkRqEK-TsMT2ndy4fgvQG1wT6AZ03Q@mail.gmail.com>
References: <CAL2FKYkoXFm_pG6inxJqwkRqEK-TsMT2ndy4fgvQG1wT6AZ03Q@mail.gmail.com>
Message-ID: <4015342.1TJkp5X8uB@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 02 March 2016 20:22:01 Yendapally Reddy Dhananjaya Reddy wrote:
> On Wed, Mar 2, 2016 at 1:55 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Tuesday 01 March 2016 12:42:49 Yendapally Reddy Dhananjaya Reddy wrote:
> >>                 };
> >>
> >> +               pwm: pwm at 31000 {
> >> +                       compatible = "brcm,iproc-pwm";
> >> +                       reg = <0x31000 0x28>;
> >> +                       clocks = <&osc>;
> >> +                       #pwm-cells = >;
> >> +                       status = "disabled";
> >> +               };
> >>
> >
> > Should this also list "brcm,kona-pwm" as compatible? From patch
> > 1, it sounds like that was the original one.
> 
> Arnd,
> 
> The NSP is a iProc based SoC and the pwm controller register offsets are
> slightly differ with the kona pwm controller. The compatible will be either
> "brcm,kona-pwm" or "brcm,iproc-pwm".

Ok, got it, thanks for the explanation.

	Arnd
