From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 16 Jul 2018 10:25:20 +0200
Subject: [PATCH 1/3 v4] ARM: dts: Modernize the Vexpress PL111 integration
In-Reply-To: <b76645a6-5145-14b5-4290-95ef1dfff4de@arm.com>
References: <20180709075232.30678-1-linus.walleij@linaro.org>
 <b00c3b85-1368-f62b-efda-d23ce27e6f9c@arm.com>
 <0bcade58-26d5-8c2f-bcba-765aebd343bb@arm.com>
 <b76645a6-5145-14b5-4290-95ef1dfff4de@arm.com>
Message-ID: <CACRpkdZEV5kDBzL1baq_MO+EMjj43bA-T_pK0PrJ=vPxdmNDLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2018 at 1:44 PM Robin Murphy <robin.murphy@arm.com> wrote:
> On 13/07/18 10:50, Sudeep Holla wrote:
> >> It doesn't work. This change is breaking the working CLCD on the models.
> >> I just tested and CLCD driver returns
> >>
> >
> > It even fails to initialize CLCD on my TC2.
> >
> > clcd-pl11x 1c1f0000.clcd: PL111 designer 41 rev1 at 0x1c1f0000
> > clcd-pl11x: probe of 1c1f0000.clcd failed with error -2
>
> FWIW the same happens on PB-A8; looks like converting to OF graph
> bindings falls foul of the "panel-dpi" check in clcdfb_of_get_mode().

That is from the old FB drivers, the defconfig changes in patch 2,3
need to be applied in lockstep with this patch. Then it "should work"
(alas I only tested PB-A8 on QEMU, which I modified to hopefully
properly model the DVI bridge).

Yours,
Linus Walleij
