From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 3 Sep 2015 22:07:31 +0200
Subject: [PATCH 2/6] ARM: dts: sunxi: Add dtsi for AXP221 PMIC
In-Reply-To: <CAGb2v66BP8UjeqF6DxHHMEsw=vo-OZvnwQavk=EC4OGE4_78MQ@mail.gmail.com>
References: <1440755679-8266-1-git-send-email-wens@csie.org>
 <1440755679-8266-3-git-send-email-wens@csie.org>
 <20150828123159.GJ29389@lukather>
 <CAGb2v66nBh+_P=EDxrNYeFoUUXqPWuZyfq1OEQww_aSMhT8wVQ@mail.gmail.com>
 <20150828204351.GS29389@lukather>
 <CAGb2v66qxgpGGzYHTP8=m-jhy2B2W2Z0iQmSed+e49PJVX_Q_w@mail.gmail.com>
 <20150901062923.GE29389@lukather>
 <CAGb2v66BP8UjeqF6DxHHMEsw=vo-OZvnwQavk=EC4OGE4_78MQ@mail.gmail.com>
Message-ID: <20150903200731.GC31584@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 01, 2015 at 02:40:23PM +0800, Chen-Yu Tsai wrote:
> On Tue, Sep 1, 2015 at 2:29 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Sat, Aug 29, 2015 at 10:07:12AM +0800, Chen-Yu Tsai wrote:
> >> >> >> +
> >> >> >> +&axp221 {
> >> >> >> +     compatible = "x-powers,axp221";
> >> >> >> +     interrupt-controller;
> >> >> >> +     #interrupt-cells = <1>;
> >> >> >> +
> >> >> >> +     regulators {
> >> >> >> +             /* Default work frequency for buck regulators */
> >> >> >> +             x-powers,dcdc-freq = <3000>;
> >> >> >> +
> >> >> >> +             /* supplies for dc1sw & dc5ldo are connected internally */
> >> >> >> +             dcdc1-supply = <&reg_dcdc1>;
> >> >> >> +             dcdc5-supply = <&reg_dcdc5>;
> >> >> >
> >> >> > so the parent regulator of DCDC1 is DCDC1 ?
> >> >>
> >> >> These probably aren't the best names. These are the supplies for DC1SW and
> >> >> DC5LDO, respectively. They are connected internally, so there aren't named
> >> >> pins for them. The comment above explains it, though probably not clearly
> >> >> enough. Furthermore, the input pins for DCDC1/5 are VIN1/5.
> >> >
> >> > I'm not quite sure I understand. They're connected internally but they
> >> > have pins ?
> >>
> >> Internally, DCDC1's output feeds the input for DC1SW (which is just a switch
> >> BTW) and DCDC5's output feeds DC5LDO (which is an LDO). Both these extra
> >> regulators have separate controls. There are no external pins to name the
> >> supplies after, so I just named them after which regulator supplies them.
> >
> > Well, there is. dc5ldo and dc1sw. And it is also how you called these
> > regulators in your DT, so it would make much more sense to have it
> > listed as such.
> 
> I was under the impression that we name them after the input pins. The names
> are also documented in Documentation/devicetree/bindings/mfd/axp20x.txt

Except that those don't have any input pins, like you said. It makes
much more sense to name them after the regulator they supply.

This property express a parenting relationship, with <child>-supply =
<parent>.

> Do you want to change them?

Yes.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150903/17b66cfc/attachment.sig>
