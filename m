From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 6 Sep 2016 22:02:00 +0200
Subject: [PATCH v2 4/7] dts: sun8i-h3: add UART1-3 to Orange Pi Plus
In-Reply-To: <CAGb2v67dnnxOp_yPyC8icu-m0WZ-Rs1STs1tnxJMOLfcRfRzUg@mail.gmail.com>
References: <1472671858-29220-1-git-send-email-jorik@kippendief.biz>
 <1472671858-29220-5-git-send-email-jorik@kippendief.biz>
 <20160902070425.GB6313@lukather>
 <20160903120932.GA6289@carbon.kippendief.biz>
 <20160905193111.GC4728@lukather>
 <CAGb2v67dnnxOp_yPyC8icu-m0WZ-Rs1STs1tnxJMOLfcRfRzUg@mail.gmail.com>
Message-ID: <20160906200200.GL9040@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 06, 2016 at 11:04:38AM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 6, 2016 at 3:31 AM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > Hi Jorik,
> >
> > On Sat, Sep 03, 2016 at 02:09:32PM +0200, Jorik Jonker wrote:
> >> On Fri, Sep 02, 2016 at 09:04:25AM +0200, Maxime Ripard wrote:
> >> >Unfortunately, these pins can be used for other purposes as well, so
> >> >we cannot make force that decision down to our users.
> >>
> >> Yes, but since the associated peripheral is disabled, the users are free to
> >> configure other functions/peripherals, right? I mean something like this in
> >> pseudo-DT:
> >>
> >> /soc/pio: pinctrl at 01c20800/uart1_pins:
> >>   allwinner,pins = "PG6, PG7";
> >> /soc/pio: pinctrl at 01c20800/foo0_pins:
> >>   allwinner,pins = "PG6, PG7";
> >>   ..
> >> /soc/uart1: serial at serial@01c28400:
> >>   pinctrl-0 = <&uart1_pins>;
> >>   status = "disabled";
> >> /soc/bar:
> >>   pinctrl-0 = <&uart1_pins>;
> >>   status = "disabled";
> >>
> >> Assuming Linux/DT allows this, this would force nothing, only offer choice
> >> and ease of use.
> >
> > Hmm, sorry, I went over your patches too quickly...
> >
> > That's a great compromise I think. Chen-Yu, any opinion on this?
> 
> In short, I'm ok with it. But please put an explicit
> 
>     status = "disabled";
> 
> and probably a comment about how/where the peripheral can be
> used in the board dts.
> 
> I intended to do this for the Banana Pis. Though my original plan
> was to enable Raspberry Pi compatible peripherals by default, and
> list the other peripherals that are defined by the vendor as
> "disabled".
> 
> "Defined by the vendor" means that the vendor has some sort of
> document associating the gpio header pins with the peripherals,
> as shown in:
> 
>     http://www.orangepi.org/Docs/Pindefinition.html#CON3_Definition
> 
> This should make it easier for the average user to enable the
> peripherals. I'm not sure we should list _all_ possible ones
> though. That would make the list very large, and some might
> end up never being used.

Having a clear limit on what we can put and what we can't isn't very
easy to do though. Any suggestion on how we can solve that?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160906/ad000d69/attachment-0001.sig>
