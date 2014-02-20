From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 20 Feb 2014 09:09:55 +0100
Subject: [PATCHv2 1/8] ARM: at91: Add at91sam9rl DT SoC support
In-Reply-To: <20140219170020.GA25079@e106331-lin.cambridge.arm.com>
References: <1392823951-26053-1-git-send-email-alexandre.belloni@free-electrons.com>
 <1392823951-26053-2-git-send-email-alexandre.belloni@free-electrons.com>
 <20140219170020.GA25079@e106331-lin.cambridge.arm.com>
Message-ID: <20140220080955.GA3142@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Wed, Feb 19, 2014 at 05:00:20PM +0000, Mark Rutland wrote:
> > +                       adc0: adc at fffd0000 {
> > +                               compatible = "atmel,at91sam9260-adc";
> > +                               reg = <0xfffd0000 0x100>;
> > +                               interrupts = <20 IRQ_TYPE_LEVEL_HIGH 0>;
> > +                               atmel,adc-use-external-triggers;
> > +                               atmel,adc-channels-used = <0xf>;
> > +                               atmel,adc-vref = <3300>;
> > +                               atmel,adc-num-channels = <4>;
> > +                               atmel,adc-startup-time = <15>;
> > +                               atmel,adc-channel-base = <0x30>;
> > +                               atmel,adc-drdy-mask = <0x10000>;
> > +                               atmel,adc-status-register = <0x1c>;
> > +                               atmel,adc-trigger-register = <0x04>;
> > +                               atmel,adc-res = <8 10>;
> > +                               atmel,adc-res-names = "lowres", "highres";
> > +                               atmel,adc-use-res = "highres";
> > +
> > +                               trigger at 0 {
> > +                                       trigger-name = "timer-counter-0";
> > +                                       trigger-value = <0x1>;
> > +                               };
> 
> A unit-address should go with a reg value. Either this needs a reg and
> the parent node needs #address-cells and #size-cells, or the
> unit-address should go, and the names made unique through other means.

What do you suggest to make the name unique then?

The ePAPR is pretty clear that the above is the way to go, so I'm
unclear on what you have in mind here.

Plus, I haven't seen anywhere that reg was actually mandatory.

Thanks!
Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140220/9ed94870/attachment.sig>
