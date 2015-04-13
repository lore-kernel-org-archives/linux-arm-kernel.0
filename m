From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 13 Apr 2015 17:59:06 +0200
Subject: [PATCH] ARM: dts: sun7i: Add Goodix GT911 nodes for Wexler TAB7200
In-Reply-To: <20150411193614.83013f345aaa1123ef55ecbf@gmail.com>
References: <1427789897-4085-1-git-send-email-mamlinav@gmail.com>
 <20150331144338.GG23664@lukather>
 <20150331223120.10199bf9e3fb41b16f879eca@gmail.com>
 <20150402185008.GC14618@lukather>
 <20150411193614.83013f345aaa1123ef55ecbf@gmail.com>
Message-ID: <20150413155906.GH29832@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 11, 2015 at 07:36:14PM +0300, Aleksei Mamlin wrote:
> On Thu, 2 Apr 2015 20:50:08 +0200
> Maxime Ripard <maxime.ripard@free-electrons.com> wrote:
> 
> > On Tue, Mar 31, 2015 at 10:31:20PM +0300, Aleksei Mamlin wrote:
> > > > > +		compatible = "goodix,gt911";
> > > > > +		reg = <0x5d>;
> > > > > +		interrupt-parent = <&pio>;
> > > > > +		interrupts = <21 IRQ_TYPE_NONE>; /* EINT21 (PH21) */
> > > > 
> > > > Unfortunately, IRQ_TYPE_NONE is not a valid value for the GIC
> > > > bindings.
> > > > 
> > >
> > > Hmm. Which value I must use in this case? IRQ type is set by the
> > > touchscreen controller driver, so I think that value must be 0.
> > 
> > Whatever the hardware is using. Presumably the same value than the
> > driver sets.
> > 
> > > >
> > > > You're also not adding a pinctrl group for that pin?
> > >
> > > No, because it works fine with this DT nodes. It seems that I should
> > > first configure pin to work in interrupt mode. Correct?
> > 
> > You don't have to, since the pio driver will already take care of
> > muxing it to the right function, but that will prevent any driver to
> > call pinctrl_request on the same pin.
>
> It is still necessary?
> I see that you have accepted Hans de Goede's patches: http://www.spinics.net/lists/arm-kernel/msg411142.html

No, it's fine.

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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20150413/568ef726/attachment-0001.sig>
